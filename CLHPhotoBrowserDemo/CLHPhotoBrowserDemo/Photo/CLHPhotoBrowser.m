//
//  CLHPhotoBrowser.m
//  onlytest
//
//  Created by AnICoo1 on 2017/4/11.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPhotoBrowser.h"
#import "UIView+CLH.h"
#import "CLHPhotoBrowserAnimator.h"
#import "CLHPhotoBrowserViewController.h"


@interface CLHPhotoBrowser () <photoBrowserAnimatorPresentDelegate>

@property (nonatomic, strong) CLHPhotoBrowserAnimator *animator;

@end

@implementation CLHPhotoBrowser

#pragma amrk - 懒加载
- (CLHPhotoBrowserAnimator *)animator{
    if(!_animator){
        _animator = [[CLHPhotoBrowserAnimator alloc] init];
    }
    return _animator;
}

- (void)setImageDataArray:(NSMutableArray<NSString *> *)imageDataArray{
    _imageDataArray = imageDataArray;
    
    NSInteger count = imageDataArray.count;
    if(count == 0){
        self.height = 0;
        return ;
    }
    //设置imageView宽高
    CGFloat imageW = [self getWidthOfImageView];
    CGFloat imageH = 0;
    if(count == 1){//只有一张图片
        UIImage *image = [UIImage imageNamed:_imageDataArray.firstObject];
        if (image.size.width) {
            imageH = image.size.height / image.size.width * imageW;
        }
    } else{
        imageH = imageW;
    }
    //获取行数
    NSInteger NumberPerRow = [self getNumberOfPerRow];
    
    for(NSInteger i = 0; i < count; i++){
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:_imageDataArray[i]];
        imageV.tag = i;
        NSInteger column = i % NumberPerRow;
        NSInteger row = i / NumberPerRow;
        CGFloat imageX = column * (imageW + 5);
        CGFloat imageY = row * (imageH + 5);
        imageV.frame = CGRectMake(imageX, imageY, imageW, imageH);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
    
    CGFloat w = NumberPerRow * imageW + (NumberPerRow - 1) * 5;
    int columnCount = ceilf(count * 1.0 / NumberPerRow);
    CGFloat h = columnCount * imageH + (columnCount - 1) * 5;
    self.width = w;
    self.height = h;
}

#pragma mark - 监听事件
- (void)click:(UITapGestureRecognizer *)tap{
    CLHPhotoBrowserViewController *photoVC = [[CLHPhotoBrowserViewController alloc] init];
    photoVC.imageArray = self.imageDataArray;
    photoVC.indexPath = [NSIndexPath indexPathForRow:tap.view.tag inSection:0];
    photoVC.modalPresentationStyle = UIModalPresentationCustom;
    photoVC.transitioningDelegate = self.animator;
    
    self.animator.animationPresentDelegate = self;
    self.animator.index = tap.view.tag;
    self.animator.animationDismissDelegate = photoVC;
    
    [self.window.rootViewController presentViewController:photoVC animated:YES completion:nil];
}

#pragma mark - photoBrowserAnimatorDelegate

- (CGRect)startRect:(NSInteger)index{
    UIImageView *imageView = nil;
    for(NSInteger i = 0; i < self.subviews.count; i++){
        if([self.subviews[i] isKindOfClass:[UIImageView class]]){
            UIImageView *view = self.subviews[i];
            if(view.tag == index){
                imageView = view;
            }
        }
    }
    return [self convertRect:imageView.frame toView:[UIApplication sharedApplication].keyWindow];
}

- (CGRect)endRect:(NSInteger)index{
    UIImage *image = [UIImage imageNamed:self.imageDataArray[index]];
    //计算imageView的frame
    CGFloat x = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width / image.size.width * image.size.height;
    CGFloat y = 0;
    if(height < [UIScreen mainScreen].bounds.size.height){
        y = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
    }
    return CGRectMake(x, y, width, height);
}

- (UIImageView *)locImageView:(NSInteger)index{
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:self.imageDataArray[index]];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (CGFloat)getWidthOfImageView{
    if(self.imageDataArray.count == 1){
        return 120;
    }else{
        return 80;
    }
}

- (NSInteger)getNumberOfPerRow{
    if (self.imageDataArray.count < 3) {
        return self.imageDataArray.count;
    } else if (self.imageDataArray.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}
@end
