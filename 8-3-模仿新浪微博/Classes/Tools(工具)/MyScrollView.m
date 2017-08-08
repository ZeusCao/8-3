//
//  MyScrollView.m
//  BinCheng
//
//  Created by Zeus on 16/11/22.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView () <UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIPageControl *pageController;
@property(nonatomic, strong)NSArray *imageArray;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, assign)NSInteger currentIndex;//当前显示的图片索引
@property(nonatomic, assign)NSInteger nextIndex;// 将要显示的图片索引


@end



@implementation MyScrollView
#pragma mark --- 初始化 ---
- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
    }
    return self;
}

#pragma mark --- 懒加载滚动视图.imageView ---
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        // imageView
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, self.width, self.height);
    }
    return _scrollView;
}

#pragma mark --- 懒加载分页视图 ---
- (UIPageControl *)pageController
{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc]init];
        _pageController.userInteractionEnabled = NO;
        _pageController.numberOfPages = self.imageArray.count;
        _pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageController;
}

#pragma mark --- 宽高 ---
- (CGFloat)width
{
    return self.scrollView.frame.size.width;
}
- (CGFloat)height
{
    return self.scrollView.frame.size.height;
}

#pragma mark --- 图片数组 ---
//- (void)setImageArray:(NSArray *)imageArray
//{
//    if (imageArray.count == 0) {
//        return;
//    }
//    _imageArray = imageArray;
//    for (int i = 0; i < imageArray.count; i ++) {
//        <#statements#>
//    }
//}

#pragma mark --- scrollView的contentSize ---
- (void)setscrollViewContentSize
{
    if (_imageArray.count > 1) {
        self.scrollView.contentSize = CGSizeMake(self.width * 6, self.height);
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    }
}

#pragma mark --- 定时器时间 ---
- (void)setTime:(NSTimeInterval)time
{
    _time = time;
    [self startTimer];
}

#pragma mark --- 定时器 ---
- (void)startTimer
{
    // 如果只有一张图片，直接返回，不开启定时器
    if (_imageArray.count <= 1) {
        return;
    }
    // 如果定时器已经开启，则先停止在重新开启
    if (self.timer) {
        [self stopTimer];
        self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(openTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
}

#pragma mark --- 开启定时器 ---
- (void)openTimer
{
    
}

#pragma mark --- 关闭定时器并且置为空 ---
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil; // 销毁定时器
}

#pragma mark --- 布局子控件 ---
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 有导航控制器时，会默认在scrollView的上方添加64的内边距，这里强制设置为0；
    _scrollView.contentInset = UIEdgeInsetsZero;
    _scrollView.frame = self.bounds;
}









@end
