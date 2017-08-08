//
//  CLNotificationCenter.m
//  BinCheng
//
//  Created by Zeus on 16/12/30.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "CLNotificationCenter.h"

@interface CLNotificationCenter  (){
    NSHashTable *delegates;
}
@end


@implementation CLNotificationCenter

// 单例
+(CLNotificationCenter *)singleton
{
    static CLNotificationCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[CLNotificationCenter alloc]init];
    });
    return center;
}

// 重写init
- (instancetype)init
{
    if (self = [super init]) {
        // 代理的初始化方法： NSHashTableWeakMemory此选项使用weak存储对象，当对象被销毁的时候自动将其从集合中移除。
        delegates = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    }
    return self;
}

// 给某个界面添加代理
- (void)addDelegate:(id<CLAppDelegate>)delegate
{
    [delegates addObject:delegate];
}

// 移除某个界面的代理
- (void)removeDelegate:(id<CLAppDelegate>)delegate
{
    [delegates removeObject:delegate];
}


- (NSHashTable *)getDelegateCopy
{
    return [delegates copy];
}
//***************************************** 通知方法 *************************************
#pragma mark --- 通知去刷新委托列表界面 ---- 1
- (void)goToRefreshProgressVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSHashTable *delegatesCopy = [self getDelegateCopy];
        for (id<CLAppDelegate>delegate in delegatesCopy) {
            if ([delegate respondsToSelector:@selector(onRefreshProgressVC)]) //如果被通知的界面存在代理方法
            {
                [delegate onRefreshProgressVC];
            }
        }
        
    });
}

#pragma mark --- 刷新我的列表界面   ---- 2
- (void)goToRefreshMyVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSHashTable *delegatesCopy = [self getDelegateCopy];
        for (id<CLAppDelegate>delegate in delegatesCopy) {
            if ([delegate respondsToSelector:@selector(onRefreshMyVC)]) //如果被通知的界面存在代理方法
            {
                [delegate onRefreshMyVC];
            }
        }
        
    });

}

#pragma mark --- 刷新消息列表界面   ---- 3
- (void)goToRefreshMessageVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSHashTable *delegatesCopy = [self getDelegateCopy];
        for (id<CLAppDelegate>delegate in delegatesCopy) {
            if ([delegate respondsToSelector:@selector(onRefreshMessageVC)]) //如果被通知的界面存在代理方法
            {
                [delegate onRefreshMessageVC];
            }
        }
        
    });
}



















@end











