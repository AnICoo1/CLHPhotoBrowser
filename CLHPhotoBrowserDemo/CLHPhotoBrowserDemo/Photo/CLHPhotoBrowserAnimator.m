//
//  CLHPhotoBrowserAnimator.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/23.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPhotoBrowserAnimator.h"


@interface CLHPhotoBrowserAnimator ()
/**判断当前动画是弹出还是消失*/
@property(nonatomic, assign, getter=isPresented) BOOL presented;

@end

@implementation CLHPhotoBrowserAnimator

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.presented = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.presented = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPresented){
        [self animationForPresentView:transitionContext];
    } else{
        [self animationForDismissView:transitionContext];
    }
}

//自定义弹出动画
- (void)animationForPresentView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //将执行的View添加到containerView
    [transitionContext.containerView addSubview:presentView];
    
    //获取开始尺寸和结束尺寸
    CGRect startRect = [self.animationPresentDelegate startRect:self.index];
    CGRect endRect = [self.animationPresentDelegate endRect:self.index];
    UIImageView *imageView = [self.animationPresentDelegate locImageView:self.index];
    [transitionContext.containerView addSubview:imageView];
    imageView.frame = startRect;
    
    presentView.alpha = 0;
    transitionContext.containerView.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = endRect;
    }completion:^(BOOL finished) {
        presentView.alpha = 1.0;
        [imageView removeFromSuperview];
        transitionContext.containerView.backgroundColor = [UIColor clearColor];
        [transitionContext completeTransition:YES];
    }];
}

//自定义消失动画
- (void)animationForDismissView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [dismissView removeFromSuperview];
    
    UIImageView *imageView = [self.animationDismissDelegate imageViewForDismissView];
    [transitionContext.containerView addSubview:imageView];
    NSInteger index = [self.animationDismissDelegate indexForDismissView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [self.animationPresentDelegate startRect:index];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
