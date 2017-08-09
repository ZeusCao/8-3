//
//  Common.swift
//  Webo10
//
//  Created by ChengXiwu on 2017/7/28.
//  Copyright © 2017年 ChengXiwu. All rights reserved.
//

import UIKit


// MARK: - 全局定义
// 定义网络访问回调方法类型
typealias AsyncCallback = (_ isSuccess: Bool, _ msg: String?)->()
typealias AsyncCallbackWithData = (_ isSuccess: Bool, _ data: Any?, _ msg: String?)->()


// MARK: - 全局函数
// 日志打印
func logPrint<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let fileNameWithoutSuffix = fileName.subString(toChar: Character("."))
        
        print("[\(fileNameWithoutSuffix)(\(line))-\(method)]: \(message)")
    #endif
}

// 延时执行方法
func delayRun(time: TimeInterval, method: @escaping ()->()){
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: method)
}


// MARK: - 全局通知
let WBSwitchRootViewControllerNotification = NSNotification.Name("WBSwitchRootViewControllerNotification")

// MARK: - 全局外观
// 界面颜色
let WBAppearanceTintColor = UIColor.orange

// MARK: - 全局字符串常量
// 获取当前版本
let CURRENT_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
// 归档根路径
let ROOT_PATH = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
// 归档文件保存路径
let ARCHIVE_PATH = ROOT_PATH + "/account.plist"
    
