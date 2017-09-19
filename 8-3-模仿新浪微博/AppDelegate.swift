//
//  AppDelegate.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupAdditons()
        
        // 申请用户授权，收取通知，包括上方的提示条，声音，badgeNumber
        // #available检测设备版本 10.0
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (success, error) in
                print("授权" + (success ? "成功" : "失败"))
            }
        } else// 10.0以下
        {
            // Fallback on earlier versions
        }
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }


}


// MARK --- 从服务器加载应用程序信息 ---
extension AppDelegate {
    fileprivate func loadAppInfo() {
        // 1 模拟异步
        DispatchQueue.global().async {
            // >1 url
            let url = Bundle.main.url(forResource: "demo.json", withExtension: nil)
            // >2 data
            let data = NSData(contentsOf: url!)
            // >3 写入磁盘
            let docDic = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let jsonPath = (docDic as! NSString).appendingPathComponent("main.json")
            data?.write(toFile: jsonPath, atomically: true)
            
        }
    }
}


// MARK --- 设置应用程序额外信息
extension AppDelegate {
    fileprivate func setupAdditons() {
        // 1，设置SVprogressHUD最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        // 2.设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
    }
}











