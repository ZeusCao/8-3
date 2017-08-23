//
//  AppDelegate.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
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














