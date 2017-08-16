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
        // 无法高亮
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        btn.setTitle("好友", for: UIControlState(rawValue: 0))
        btn.setTitleColor(UIColor.darkGray, for: UIControlState(rawValue: 0))
        btn.setTitleColor(UIColor.orange, for: UIControlState(rawValue: 1))
        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        navItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    
    
    
    
    //fileprivate
}
