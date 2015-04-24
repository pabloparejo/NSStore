//
//  PARAnimator.m
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 10/4/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "PARAnimator.h"
#import "PARStoreViewController.h"
#import "PARProductDetailViewController.h"
@implementation PARAnimator


- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .75;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // Escenario donde hago la animación
    UIView *contextView = [transitionContext containerView];
    [contextView setBackgroundColor:[UIColor whiteColor]];
    
    // Controlador origen
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // Controlador destino
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGAffineTransform fromVCTransform = CGAffineTransformIdentity;
    
    // Crea la situación inicial
    if (self.animationType != AnimatorDismiss) {
        [contextView insertSubview:toVC.view belowSubview:fromVC.view];
        [toVC.view layoutIfNeeded];
    }
    
    UIImageView *cellImage = nil;
    if (self.animationType == AnimatorPresent || self.animationType == AnimatorPush) {
        [toVC.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
        //fromVCTransform = CGAffineTransformMakeTranslation(-200, 0);
        ProductReusableView *selectedCell = [(PARStoreViewController *) fromVC selectedCell];
        [[((PARProductDetailViewController *) toVC) imageView] setAlpha:0];
        
        cellImage = [[UIImageView alloc] initWithImage:[[selectedCell imageView] image]];
        [cellImage setContentMode:UIViewContentModeScaleAspectFill];
        [cellImage setClipsToBounds:YES];
        cellImage.frame = selectedCell.frame;
    }else{
        //fromVCTransform = CGAffineTransformMakeTranslation(200, 0);
        [toVC.view.layer setTransform:CATransform3DMakeScale(2.5, 2.5, 2.5)];
    }
    [contextView insertSubview:cellImage aboveSubview:toVC.view];

    toVC.view.frame = [[UIScreen mainScreen] bounds];
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState;

    toVC.view.alpha = 0.0;
    [UIView animateWithDuration:.75 delay:0 options:options animations:^{
        fromVC.view.alpha = 0.0;
        fromVC.view.transform = fromVCTransform;
        toVC.view.alpha = 1;
        [toVC.view setTransform:CGAffineTransformIdentity];
        if (cellImage != nil) {
            NSLog(@"%f, %f", [[((PARProductDetailViewController *) toVC) imageView] frame].origin.x, [[((PARProductDetailViewController *) toVC) imageView] frame].origin.y);
            CGRect frame = [[((PARProductDetailViewController *) toVC) imageView] frame];

            cellImage.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

        }

    } completion:^(BOOL finished) {
        if (cellImage != nil) {
            [[((PARProductDetailViewController *) toVC) imageView] setAlpha:1];
        }
        [UIView animateWithDuration:0.2 animations:^{
            [toVC.view setTransform:CGAffineTransformIdentity];
            if (cellImage != nil) {
                [cellImage setAlpha:0];
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [toVC.view.layer setTransform:CATransform3DIdentity];
            [cellImage removeFromSuperview];

        }];
    }];
}

@end
