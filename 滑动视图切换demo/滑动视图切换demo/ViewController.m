//
//  ViewController.m
//  滑动视图切换demo
//
//  Created by macbook on 15/8/9.
//  Copyright (c) 2015年 lych. All rights reserved.
//

#import "ViewController.h"

#define kSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UICollectionViewDelegate>
{
    UIScrollView *_scrollView; // 滚动视图
    UIPageControl *_pageControl; // 页面小圆圈
    NSUInteger _currentIndex; //当前所在视图索引
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor brownColor]];
    [self initScorllView];
    [self addPageControl];
    [self setDefaultInfo];
}

#pragma mark - 初始化滚动视图
- (void)initScorllView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
    _scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH * 3, KSCREEN_HEIGHT - 64);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [self addViewToScrollView];
}

// 添加三个view到滚动视图
- (void)addViewToScrollView
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
    leftView.backgroundColor = [UIColor redColor];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
    centerView.backgroundColor = [UIColor blueColor];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH * 2, 0, kSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
    rightView.backgroundColor = [UIColor grayColor];
    
    [_scrollView addSubview:leftView];
    [_scrollView addSubview:centerView];
    [_scrollView addSubview:rightView];
    _scrollView.contentOffset = CGPointMake(kSCREEN_WIDTH, 0.0);
}

// 添加页面控制
- (void)addPageControl
{
    _pageControl = [[UIPageControl alloc] init];
    CGSize size = [_pageControl sizeForNumberOfPages:3];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(kSCREEN_WIDTH/2, KSCREEN_HEIGHT - 100);
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:_pageControl];
}

// 设置页面控制当前页
- (void)setPageControlIndex:(NSUInteger)index
{
    _pageControl.currentPage = index;
}

// 设置默认信息
- (void)setDefaultInfo
{
    _currentIndex = 1;
    
    [self setPageControlIndex:_currentIndex];
}

// 滚动后结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x > kSCREEN_WIDTH) {
        _currentIndex = 2;
    } else if (offset.x < kSCREEN_WIDTH) {
        _currentIndex = 0;
    } else {
        _currentIndex = 1;
    }
    
    [self setPageControlIndex:_currentIndex];
    
}

@end













