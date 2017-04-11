//
//  ViewController.m
//  CLHPhotoBrowserDemo
//
//  Created by AnICoo1 on 2017/4/11.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "ViewController.h"
#import "CLHPhotoBrowser.h"

@interface ViewController ()

@property (nonatomic, strong) CLHPhotoBrowser *photoBrowser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLHPhotoBrowser *photoB = [[CLHPhotoBrowser alloc] initWithFrame:CGRectMake(0, 150, 375, 300)];
    NSArray *arr = [NSArray arrayWithObjects:@"fanguang-1", @"fanguang-2", @"fanguang-3", nil];
    photoB.imageDataArray = [arr copy];
    _photoBrowser = photoB;
    _photoBrowser.backgroundColor = [UIColor redColor];
    [self.view addSubview:_photoBrowser];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
