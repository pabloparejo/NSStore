//
//  PARStoreViewController.m
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 28/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARStoreViewController.h"
#import "ProductReusableView.h"
#import "PARProductDetailViewController.h"
#import "HeaderCollectionReusableView.h"
#import "PARAnimator.h"

#define SECTION_TITLE_KEY @"SECTION_TITLE"
#define PRODUCTS_KEY @"PRODUCTS_KEY"
#define NAME_KEY @"NAME_KEY"
#define URL_KEY @"URL_KEY"
#define PRICE_KEY @"PRICE_KEY"

#define CELL_ID @"CELL_ID"
#define HEADER_ID @"HEADER_ID"

@interface PARStoreViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveAnimator;
@end

@implementation PARStoreViewController

- (instancetype) initWithModel:(NSArray *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Todo a chien"];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductReusableView" bundle:nil] forCellWithReuseIdentifier:CELL_ID];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    /*if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.model count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[self.model objectAtIndex:section] objectForKey:PRODUCTS_KEY] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductReusableView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID
                                                                          forIndexPath:indexPath];
    [cell.imageView  setImage:nil];
    [cell.loading startAnimating];
    
    NSDictionary *product = [self productForIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[product objectForKey:URL_KEY]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [cell.imageView setImage:[UIImage imageWithData:data]];
        [cell.loading stopAnimating];
    }];
    
    [cell.textLabel setText:[product objectForKey:NAME_KEY]];
    [cell.priceLabel setText:[product objectForKey:PRICE_KEY]];
    
    cell.layer.masksToBounds = NO;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shouldRasterize = YES;
    
    
    return cell;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView
            viewForSupplementaryElementOfKind:(NSString *)kind
                                  atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:HEADER_ID
                                                                                         forIndexPath:indexPath];
        [header.sectionTitle setText:[[self.model objectAtIndex:indexPath.section]
                                      objectForKey:SECTION_TITLE_KEY]];
        return header;

    }
    return nil;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:YES];
    
    UIScreenEdgePanGestureRecognizer *edgeRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                         action:@selector(edgeGestureRecognized:)];
    edgeRecognizer.edges = UIRectEdgeLeft;
    NSDictionary *product = [self productForIndexPath:indexPath];
    PARProductDetailViewController *detailVC = [[PARProductDetailViewController alloc] initWthProduct:product recognizer:edgeRecognizer];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    detailVC.transitioningDelegate = self;
    
    //detailVC.modalPresentationStyle = UIModalPresentationCustom;
    //[self presentViewController:detailVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - Utils

-(NSDictionary *) productForIndexPath:(NSIndexPath *) indexPath{
    return [[[self.model objectAtIndex:indexPath.section] objectForKey:PRODUCTS_KEY]objectAtIndex:indexPath.row];
}

#pragma mark - UIViewControllerTransitioningDelegate

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    PARAnimator *animator = [PARAnimator new];
    [animator setAnimationType: AnimatorPresent];
    return animator;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed{
    PARAnimator *animator = [PARAnimator new];
    [animator setAnimationType: AnimatorDismiss];
    return animator;
}

-(id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    PARAnimator *animator = [PARAnimator new];
    if (operation == UINavigationControllerOperationPush) {
        [animator setAnimationType:AnimatorPush];
    }else if (operation == UINavigationControllerOperationPop){
        [animator setAnimationType:AnimatorPop];
    }else{
        return nil;
    }
    return animator;
}

- (void)edgeGestureRecognized:(UIScreenEdgePanGestureRecognizer *)recognizer{
    // We should add this in detail view
    
    float progress = [recognizer translationInView:self.view].x / self.view.frame.size.width;
    
    NSLog(@"%f", progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan){
        self.interactiveAnimator = [UIPercentDrivenInteractiveTransition new];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self.interactiveAnimator updateInteractiveTransition:progress + .05];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (progress > .2) {
            [self.interactiveAnimator finishInteractiveTransition];
        }else{
            [self.interactiveAnimator cancelInteractiveTransition];
        }
        self.interactiveAnimator = nil;
    }
}

-(id<UIViewControllerInteractiveTransitioning>) navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactiveAnimator;
}
@end
