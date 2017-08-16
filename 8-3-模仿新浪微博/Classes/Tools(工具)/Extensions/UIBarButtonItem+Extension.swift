//
//  UIBarButtonItem+Extension.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/10.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action:Selector, isBackBtn: Bool = false) {
        //let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        let btn = UIButton()
        
        btn.setTitle(title, for: UIControlState(rawValue: 0))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(UIColor.darkGray, for: UIControlState(rawValue: 0))
        btn.setTitleColor(UIColor.orange, for: UIControlState(rawValue: 1))
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if isBackBtn {
            btn.setImage(UIImage(named: "nav返回"), for: .normal)
            btn.setImage(UIImage(named: "通用-返回"), for: .highlighted)
            btn.sizeToFit()
        }
        
        // 调self.init实例化UIBarButtonItem
        self.init(customView: btn)
    }
}
