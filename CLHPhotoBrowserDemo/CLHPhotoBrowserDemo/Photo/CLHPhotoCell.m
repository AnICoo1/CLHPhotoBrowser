//
//  CLHPhotoCell.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPhotoCell.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@implementation CLHPhotoCell
{
    UIScrollView *_scrollView;
}
- (void)setImageView:(UIImageView *)imageView{
    _imageView = imageView;
    UIImage *image = _imageView.image;
    //添加图片点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)];
    [_imageView addGestureRecognizer:tap];
    //默认imageView的userInteractionEnabled为NO，所以应修改为YES
    _imageView.userInteractionEnabled = YES;
    //计算imageView的frame
    CGFloat x = 0;
    CGFloat width = screenW;
    CGFloat height = width / image.size.width * image.size.height;
    CGFloat y = 0;
    if(height < screenH){
        y = (screenH - height) * 0.5;
    }
    _imageView.frame = CGRectMake(x, y, width, height);
    //设置scrollView属性
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(0, height);
    [_scrollView addSubview:_imageView];
    [self.contentView addSubview:_scrollView];
}


- (void)imageViewClick{
    if([self.delegate respondsToSelector:@selector(imageViewDidClick)]){
        [self.delegate imageViewDidClick];
    }
}

@end
