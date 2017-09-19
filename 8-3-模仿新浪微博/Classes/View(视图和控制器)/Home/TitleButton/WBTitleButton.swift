//
//  WBTitleButton.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/5.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    // 重载构造函数
    // title如果为nil就显示首页
    init(title: String) {
        super.init(frame: CGRect())
        // 判断为空
        if title  == "" {
            setTitle("首页", for: .normal)
        }else {
            setTitle(title + "", for: .normal)
            setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControlState.normal)
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        // 设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        
        // 设置大小
        sizeToFit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 重新布局子视图 一定要super
    override func layoutSubviews() {
        super.layoutSubviews()
        // 判断是否同时存在
        guard let titleLabel = titleLabel ,let imageView = imageView else {
            return
        }
        // 将label的x向左移动imageview的宽度
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        // 将imageview的x向右移动label的宽度
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width + 1, dy: 0)
    }

}
