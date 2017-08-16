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
        setupComposeButton()
    }
    
    /*
     - viewController中实现的方法
     - 使用代码控制设备的方向，可以在需要横屏的时候单独处理
     - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
     **/
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .portrait
    }
   
    
    // 添加按钮
    lazy var composeButton: UIButton = UIButton()
    
    // MARK --- 按钮的监听方法 ---
      // private 能够保证方法私有，仅在当前对象被访问
      // @objc 允许这个函数在运行时通过OC的消息机制被调用
      func composeStatus() {
        print("撰写微博")
    }

}


// extension 类似于oc中的分类，在swift中还可以用来切分代码块
// 可以把相近功能的函数放在extension中
// 便于 维护代码
// 注意：和oc的分类一样，extension中不能定义属性，只能定义方法

// MARK------- 设置界面
extension WBMainController {
    // 设置添加按钮
   fileprivate func setupComposeButton() {
        composeButton.setImage(UIImage(named: "buttonAdd"), for: UIControlState(rawValue: 0))
        // 计算宽度
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count - 1// 为了防止点到容错点
        composeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        // oc中CGRectInset 正数向内缩进，负数向外扩散
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0) //（因为w－1 能够让其宽度变大，覆盖掉容错点）
       tabBar.addSubview(composeButton)
        
        // 添加撰写按钮的的点击方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置所有自控制器
     func  setupChildControllers() {
        
        let array = [
            ["clsName" : "WBHomeViewController", "title" : "首页", "imageName" : "113"],
            ["clsName" : "WBMessageViewController", "title" : "消息", "imageName" : "113"],
            ["clsName" : ""],
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
        
        // 设置tabbar的标题字体
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        // 大小
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)] , for:UIControlState(rawValue: 0))
        
        // 实例化导航控制器的时候，会调用push方法将rootVC压栈
        let nav = WBNavigationController(rootViewController: vc)
        return nav
        
    }
    
}










