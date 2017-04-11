//
//  CLHPhotoBrowserViewController.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPhotoBrowserViewController.h"
#import "CLHPhotoCell.h"

@interface CLHPhotoBrowserViewController () <photoCellDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@end

static NSString *ID = @"cell";

@implementation CLHPhotoBrowserViewController
{
    UICollectionView *_collectionView;
    UIPageControl *_pageControl;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpAll];
    //跳转到指定页
    [_collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition: UICollectionViewScrollPositionLeft animated:NO];
    _pageControl.currentPage = self.indexPath.row;
}

- (void)setUpAll{
    //设置分页器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 20)];
    _pageControl.currentPage = 1;
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    //collectionView设置
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[CLHPhotoCell class] forCellWithReuseIdentifier:ID];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.frame = self.view.bounds;
    [self.view insertSubview:_collectionView atIndex:0];
}

#pragma mark - UICollectionViewDelegate

//collection滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contenOffset = scrollView.contentOffset.x;
    //通过滚动算出在哪一页
    int page = contenOffset / scrollView.frame.size.width + ((int)contenOffset % (int)scrollView.frame.size.width == 0 ? 0 : 1);
    _pageControl.currentPage = page;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = self.imageArray.count;
    _pageControl.numberOfPages = count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLHPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
    cell.delegate = self;
    return cell;
}

- (void)imageViewDidClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - photoBrowserAnimatorDismissDelegate

- (NSInteger)indexForDismissView{
    CLHPhotoCell *cell = [_collectionView visibleCells].firstObject;
    return [_collectionView indexPathForCell:cell].row;
}

- (UIImageView *)imageViewForDismissView{
    UIImageView *imageView = [[UIImageView alloc] init];
    CLHPhotoCell *cell = [_collectionView visibleCells].firstObject;
    imageView.image = cell.imageView.image;
    imageView.frame = cell.imageView.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

@end
