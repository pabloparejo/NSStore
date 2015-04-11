//
//  PARAnimator.m
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 10/4/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARAnimator.h"



@implementation PARAnimator


- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // Escenario donde hago la animación
    UIView *contextView = [transitionContext containerView];
    
    // Controlador origen
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // Controlador destino
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGAffineTransform fromVCTransform = CGAffineTransformIdentity;
    // Crea la situación inicial
    if (self.animationType != AnimatorDismiss) {
        [contextView insertSubview:toVC.view belowSubview:fromVC.view];
    }
    
    if (self.animationType == AnimatorPresent || self.animationType == AnimatorPush) {
        [toVC.view.layer setTransform:CATransform3DMakeScale(.75, .75, .75)];
        fromVCTransform = CGAffineTransformMakeScale(2.75, 2.75);
    }else{
        fromVCTransform = CGAffineTransformMakeScale(0.75, 0.75);
        [toVC.view.layer setTransform:CATransform3DMakeScale(2.5, 2.5, 2.5)];
    }
    
    toVC.view.frame = fromVC.view.frame;
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;
    
    toVC.view.alpha = 0.0;
    [UIView animateWithDuration:1 delay:0 options:options animations:^{
        fromVC.view.alpha = 0.0;
        fromVC.view.transform = fromVCTransform;
        toVC.view.alpha = 1;
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
