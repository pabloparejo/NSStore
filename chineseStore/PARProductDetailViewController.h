//
//  PARProductDetailViewController.h
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 28/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARProductDetailViewController : UIViewController

-(instancetype) initWthProduct:(NSDictionary *) product;
-(instancetype) initWthProduct:(NSDictionary *) product recognizer:(UIScreenEdgePanGestureRecognizer *)recognizer;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
