//
//  UIButton+Extension.swift
//  Webo10
//
//  Created by ChengXiwu on 2017/7/28.
//  Copyright © 2017年 ChengXiwu. All rights reserved.
//

import UIKit

extension String{
    
    // 得到某字符在字符串中的索引位置
    func index(of: Character)->String.Index{
        var i = 0
        for s in self.characters{
            i += 1
            if s == of {
                break
            }
        }
        return index(self.startIndex, offsetBy: i - 1)
    }

    // 截取到某指定字符
    func subString(toChar: Character)->String{
        let i = index(of: toChar)
        return substring(to: i)
    }
}

extension UILabel{
    
    convenience init(title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.darkGray){
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0
        textAlignment = NSTextAlignment.center
        
    }
}

extension UIButton{
    
    convenience init(imageName: String, backImageName: String) {
        self.init()

        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        setBackgroundImage(imageName: backImageName, status: UIControlState.normal)
        setBackgroundImage(imageName: backImageName + "_highlighted", status: UIControlState.normal)
        // 会根据图片自适应尺寸
        sizeToFit()
    }
    
    convenience init(title: String, foreColor: UIColor, backgroundImageName: String){
        self.init()
        setTitle(title, for: UIControlState.normal)
        setTitleColor(foreColor, for: UIControlState.normal)
        setBackgroundImage(imageName: backgroundImageName, status: UIControlState.normal)
//        setBackgroundImage(imageName: backgroundImageName + "_highlighted", status: UIControlState.normal)
        // 根据文字调整尺寸
        sizeToFit()
    }
    
    convenience init(title: String, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor, backgroundImageName: String) {
        self.init()
        setTitle(title, for: UIControlState.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(normalColor, for: UIControlState.normal)
        setTitleColor(highlightedColor, for: UIControlState.highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), for: UIControlState.normal)
    }
    
    
    func setBackgroundImage(imageName: String, status: UIControlState){
        setBackgroundImage(UIImage(named: imageName), for: status)
    }
}

extension  UIImageView{
    
    convenience init(imageName: String){
        self.init(image: UIImage(named: imageName))
    }
}






