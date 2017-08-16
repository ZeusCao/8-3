//
//  WBDemoViewController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/9.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置标题
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
       
    }
    
    @objc fileprivate func showNext() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
   
    
}


extension WBDemoViewController{
    
    override func setupUI() {

        super.setupUI()
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        btn.setTitle("下一个", for: UIControlState(rawValue: 0))
        btn.setTitleColor(UIColor.darkGray, for: UIControlState(rawValue: 0))
        btn.setTitleColor(UIColor.orange, for: UIControlState(rawValue: 1))
        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
    }
    
}
