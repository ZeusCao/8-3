//
//  WBStatusPicture.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/11.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

// 微博配图模型
class WBStatusPicture: NSObject {

    // 缩略图地址
    var thumbnail_pic: String?
    
    override var description: String {
        return yy_modelDescription()
    }
}
