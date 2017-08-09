//
//  WBHomeViewController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8468805552, blue: 0.5303781629, alpha: 1)
    }

    @objc fileprivate func showFriends(){
        print(#function)
        
        let vc = WBDemoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension WBHomeViewController{
    
    // 重写父类的方法
    override func setupUI() {
        super.setupUI()
        // 设置导航栏
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
    }
    
    
    
    
    
    //fileprivate
}
