//
//  WBStatusPictureView.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/8.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    
    // 配图视图的数组
    var urls: [WBStatusPicture]? {
        didSet {
            // 1.隐藏所有的imageView
            for v in subviews {
                v.isHidden = true
            }
            
            // 2.遍历urls数组，顺序设置图像
            var index = 0
            for url in urls ?? [] {
                 let iv = subviews[index] as! UIImageView
                 // 设置图像
                 iv.cz_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                
                 // 4张图像的处理
                if  index == 1 && urls?.count == 4 {
                    index += 1
                }
                
                 // 显示图像
                 iv.isHidden = false
                 index += 1
            }
        }
    }
    

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }

}

// 设置界面
extension WBStatusPictureView {
    
    // 1. cell中所有的数据都要提前准备好
    // 2. 设置的时候根据数据决定是否显示
    // 3. 不要动态创建控件
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = superview?.backgroundColor
        
        // 超出边界的内容不显示
        clipsToBounds = true
        
        let count = 3
        let rect = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWidth, height: WBStatusPictureItemWidth)
        
        // 循环创建9个
        for i in 0..<count * count {
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            // 行 -> Y
            let row = CGFloat(i / count)
            // 列 -> X
            let col = CGFloat(i % count)
            
            let xOffset = col * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            let yOffset = row * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            addSubview(iv)
        }
        
    }
    
}
