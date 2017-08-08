//
//  WBMainController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
    }

}


// extension 类似于oc中的分类，在swift中还可以用来切分代码块
// 可以把相近功能的函数放在extension中
// 便于 维护代码
// 注意：和oc的分类一样，extension中不能定义属性，只能定义方法

// MARK------- 设置界面
extension WBMainController {
    
    // 设置所有自控制器
     func  setupChildControllers() {
        
        let array = [
            ["clsName" : "WBHomeViewController", "title" : "首页", "imageName" : "113"],
            ["clsName" : "WBMessageViewController", "title" : "消息", "imageName" : "113"],
            ["clsName" : "WBDiscoverViewController", "title" : "发现", "imageName" : "113"],
            ["clsName" : "WBProfileViewController", "title" : "我", "imageName" : "113"]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            
            arrayM.append(controller(dict:dict))
        }
        
        viewControllers = arrayM

    }
    
    // 使用字典创建一个自控制器
    /// --parameter dict: 信息字典[clsName ,title, imageName]
    /// --returns: 子控制器
    private func controller(dict:[String : String]) -> UIViewController{
        
        // 1. 获取字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
            //let cls = NSClassFromString(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""  + "." + clsName) as? UIViewController.Type
        //let cls  = NSClassFromString("模仿新浪微博.WBHomeViewController") as? UIViewController.Type

            else{
                            return UIViewController()
            }
        
        // 2.创建视图控制器
    
        let vc = cls.init()
        vc.title = title
        
        // 设置图像
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "103")?.withRenderingMode(.alwaysOriginal)
        
        let nav = WBNavigationController(rootViewController: vc)
        return nav
        
    }
    
}










