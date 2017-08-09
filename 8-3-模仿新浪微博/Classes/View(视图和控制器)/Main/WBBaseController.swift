//
//  WBBaseController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
        
    }

   
}


// MARR --- 设置界面
// 隔离代码
extension WBBaseController {
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

    }
    
}
