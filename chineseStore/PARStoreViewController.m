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

#define SECTION_TITLE_KEY @"SECTION_TITLE"
#define PRODUCTS_KEY @"PRODUCTS_KEY"
#define NAME_KEY @"NAME_KEY"
#define URL_KEY @"URL_KEY"
#define PRICE_KEY @"PRICE_KEY"

#define CELL_ID @"CELL_ID"
#define HEADER_ID @"HEADER_ID"

@interface PARStoreViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    /*
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@(metodo:)
                                                    userInfo:nil
                                                     repeats:YES];
    [timer invalidate];*/
    // Dispose of any resources that can be recreated.
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

#pragma mark - <UICollectionViewDelegate>

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:YES];
    NSDictionary *product = [self productForIndexPath:indexPath];
    PARProductDetailViewController *detailVC = [[PARProductDetailViewController alloc] initWthProduct:product];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //[self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Utils

-(NSDictionary *) productForIndexPath:(NSIndexPath *) indexPath{
    return [[[self.model objectAtIndex:indexPath.section] objectForKey:PRODUCTS_KEY]objectAtIndex:indexPath.row];
}

@end
