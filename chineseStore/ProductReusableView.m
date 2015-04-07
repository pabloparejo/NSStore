//
//  ProductReusableView.m
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 28/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "ProductReusableView.h"

@implementation ProductReusableView

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 7;
    self.priceLabel.layer.cornerRadius = 4;
}

-(void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        [self.imageView setAlpha:0.8];
        [self.textLabel setAlpha:0.95];
        [UIView animateWithDuration:1.5 animations:^{
            CATransform3D transformer = CATransform3DMakeRotation(M_PI, 0.5, 0.25, 0);
            self.layer.transform = CATransform3DTranslate(transformer, 100, 0, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.layer.transform = CATransform3DIdentity;
            }];
        }];
    }else{
        [self.imageView setAlpha:1];
        [self.textLabel setAlpha:1];
    }
    
    
}

@end
