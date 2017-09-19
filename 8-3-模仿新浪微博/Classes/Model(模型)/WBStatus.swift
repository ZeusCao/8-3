////  WBStatus.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/25.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit
import YYModel
// 微博数据模型
class WBStatus: NSObject {

    // int类型，在64位的机型是64位，在32位的机型是32位的
    // 如果不写int64 在ipad2/iPhone5/5c/5s/4s/4 上都无法正常运行
    var id: Int64 = 0
    
    // 微博信息内容
    var text: String?
    
    // 转发数
    var reposts_count: Int = 0
    // 评论数
    var comments_count: Int = 0
    // 点赞数
    var attitudes_count: Int = 0
    
    // 微博的用户
    var user: WBUser?
    
    // 微博配图模型数组
    var pic_urls: [WBStatusPicture]?
    
    
    // 开发模型需要重写description的计算型属性(为了打印出的是具体的属性而不是对象的地址)
    override var description: String{
        return yy_modelDescription()
    }
    
    // 类函数： 告诉第三方YYmodel， 如果遇到数组类型的属性，数组中存放的对象是什么类，做一个映射
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls" : WBStatusPicture.self]
    }
    
    
    
    
}










