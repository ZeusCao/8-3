//
//  WBUser.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/7.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit


// 微博用户模型
class WBUser: NSObject {

    // 基本数据类型和private不能使用KVC设置
    var id: Int64 = 0
    // 用户昵称
    var screen_name: String?
    // 用户头像地址
    var profile_image_url: String?
    // 认证类型,-1为没有认证,0为认证用户,2,3,5为企业认证, 220:达人
    var verified_type: Int = 0
    // 会员等级 0-6
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
