//
//  WBNavigationController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        
        navigationBar.isHidden = true
        
    }

    // 重写push方法
    // viewcontroller 是被push的控制器，设置他左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = viewController as? WBBaseController{
                
                var title = "返回"
                // 判断控制器的级数（只有一个控制器的时候显示栈底控制器的标题）
                if childViewControllers.count == 1 {
                    // title 需要显示首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                
                // 取出自定义的navItem,设置左侧按钮为返回按钮
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, fontSize: 16, target: self, action: #selector(popToPresent), isBackBtn:true)
            }

        }
        // 判断控制器的类型
        super.pushViewController(viewController, animated: true)
        
    }
    
    // pop返回到上一级控制器
    @objc fileprivate func popToPresent() {
        popViewController(animated: true)
    }

}
