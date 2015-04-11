//
//  PARProductDetailViewController.m
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 28/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARProductDetailViewController.h"


#define SECTION_TITLE_KEY @"SECTION_TITLE"
#define PRODUCTS_KEY @"PRODUCTS_KEY"
#define NAME_KEY @"NAME_KEY"
#define URL_KEY @"URL_KEY"
#define PRICE_KEY @"PRICE_KEY"

#define MINLENGTH 12

@interface PARProductDetailViewController ()

@property (nonatomic, copy) NSDictionary *product;

@end

@implementation PARProductDetailViewController

-(instancetype) initWthProduct:(NSDictionary *) product{
    if(self = [super init]){
        _product = product;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *text = [self.product objectForKey:NAME_KEY];
    self.title = ([text length]>MINLENGTH ? [[text substringToIndex:MINLENGTH] stringByAppendingString:@"..."] : text);
    [self.titleLabel setText:[self.product objectForKey:NAME_KEY]];
    [self.priceLabel setText:[self.product objectForKey:PRICE_KEY]];
    [self.priceLabel.layer setCornerRadius:4];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.product objectForKey:URL_KEY]]];
    [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [self.imageView setImage:[UIImage imageWithData:data]];
    }];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissController:(id)sender {
    /*if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }*/
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
