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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
    }
    
}
