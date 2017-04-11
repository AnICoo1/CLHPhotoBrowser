//
//  CLHPhotoCell.h
//  wechats
//
//  Created by AnICoo1 on 2017/3/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 图片查看器cell协议
 */
@protocol photoCellDelegate <NSObject>

/**
 图片查看器被点击
 */
- (void)imageViewDidClick;

@end

@interface CLHPhotoCell : UICollectionViewCell
/**图片*/
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id<photoCellDelegate> delegate;

@end
