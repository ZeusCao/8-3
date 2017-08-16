//
//  WBVisitorView.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/16.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

 // 访客视图
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// 设置界面
extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
    }
}
