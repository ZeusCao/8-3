//
//  UIImageView+Extension.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/8.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func cz_avatarImage(size: CGSize?, backColor: UIColor = UIColor.white, lineColor: UIColor = UIColor.lightGray) -> UIImage {
        var size = size
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        //1. 图形上下文，内存中开辟一个地址
        // 1）. size 绘图的尺寸
        // 2）. 不透明 false（透明）/ true（不透明）
        // 3）. scale 屏幕分辨率 默认1.0的分辨率，设置成0会根据设备自动区分
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 0.> 裁切前的背景填充
        backColor.setFill()
        UIRectFill(rect)
        
        // 1.> 实例化一个圆形的路径
        let path = UIBezierPath(ovalIn: rect)
        // 2.> 进行路径的圆形裁切，后续的绘图都会出现在圆形路径的内部，外部的都会被去掉
        path.addClip()
        
        //2. 绘图 drawRect 就是在指定区域内拉伸屏幕
        draw(in: rect)
        
        // 3. 绘制内切的圆形边框
        lineColor.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        
        //4. 获取结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        //5. 关闭上下文
        UIGraphicsEndImageContext()
        
        //6. 返回结果
        return result!

        
    }
    
}
