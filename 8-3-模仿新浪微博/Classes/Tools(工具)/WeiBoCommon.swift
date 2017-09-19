//
//  WeiBoCommon.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/29.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation

// MARK --- 应用程序信息 ---
let WBAppKey = "3634637065" // 应用程序ID
let WBAppSecret = "bf6b5a63545d3e51025089f45cea729f" // 应用程序加密信息
let WBRedirectURI = "http://baidu.com" // 回调地址



// MARK --- 全局通知定义
// 用户是否需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"

let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"

// MARK --- 微博配图视图常量
// 配图视图外侧的间距
let WBStatusPictureViewOutterMargin: CGFloat = 12
// 配图视图内部的间距
let WBStatusPictureViewInnerMargin: CGFloat = 3
// 计算配图视图的宽度
let WBStatusPicViewWidth = UIScreen.main.bounds.size.width - 2 * WBStatusPictureViewOutterMargin
// 计算每个item默认的宽度
let WBStatusPictureItemWidth = (WBStatusPicViewWidth - 2 * WBStatusPictureViewInnerMargin) / 3
