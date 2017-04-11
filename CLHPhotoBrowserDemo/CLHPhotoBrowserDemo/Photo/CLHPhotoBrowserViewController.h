//
//  CLHPhotoBrowserViewController.h
//  wechats
//
//  Created by AnICoo1 on 2017/3/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLHPhotoBrowserAnimator.h"

@interface CLHPhotoBrowserViewController : UIViewController <photoBrowserAnimatorDismissDelegate>


@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSIndexPath *indexPath;



@end
