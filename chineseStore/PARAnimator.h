//
//  PARAnimator.h
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 10/4/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AnimatorPresent,
    AnimatorDismiss,
    AnimatorPush,
    AnimatorPop
} AnimationType;

@interface PARAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic) AnimationType animationType;

@end
