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


-(void) setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        [UIView animateWithDuration:.2 animations:^{
            [self.imageView setAlpha:0.8];
            [self.textLabel setAlpha:0.95];
        }];
    }else{
        [UIView animateWithDuration:.2 animations:^{
            [self.imageView setAlpha:1];
            [self.textLabel setAlpha:1];
        }];
    }
}

@end
