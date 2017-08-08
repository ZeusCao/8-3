//
//  CLNotificationCenter.h
//  BinCheng
//
//  Created by Zeus on 16/12/30.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import <Foundation/Foundation.h>

// 代理
@protocol CLAppDelegate <NSObject>

@optional
#pragma mark --- 刷新委托列表界面(在委托列表界面实现的方法) ---- 1
- (void)onRefreshProgressVC;

#pragma mark --- 刷新我的列表界面(在我的界面实现的方法) ---- 2
- (void)onRefreshMyVC;

#pragma mark --- 刷新消息列表界面(在消息列表实现的方法) ---- 3
- (void)onRefreshMessageVC;
@end






@interface CLNotificationCenter : NSObject

+(CLNotificationCenter *)singleton;

- (void)addDelegate:(id<CLAppDelegate>)delegate; // 给某个界面添加代理
- (void)removeDelegate:(id<CLAppDelegate>)delegate; // 移除某个界面的代理

#pragma mark --- 通知去刷新委托列表界面 ---- 1
- (void)goToRefreshProgressVC;
#pragma mark --- 刷新我的列表界面   ---- 2
- (void)goToRefreshMyVC;
#pragma mark --- 刷新消息列表界面   ---- 3
- (void)goToRefreshMessageVC;
@end
