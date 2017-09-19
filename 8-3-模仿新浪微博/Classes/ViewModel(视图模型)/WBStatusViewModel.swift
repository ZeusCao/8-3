//
//  WBStatusViewModel.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/7.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation

/*
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要：
 1. 遵守CustomStringConvertible
 2. 实现description 计算型属性
 */

// 单条微博视图模型
class WBStatusViewModel: CustomStringConvertible {
    
    // 微博模型
    var status: WBStatus
    
    // 会员图标
    var memberIcon: UIImage?
    
    // 认证类型
    var vipIcon: UIImage?
    
    // 转发文字
    var retweetedStr: String?
    // 评论文字
    var commentStr: String?
    // 点赞文字
    var likeStr: String?
    
    // 配图视图大小
    var picViewSize = CGSize()
    
    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    init(model: WBStatus) {
        self.status = model
        //会员等级1-6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        // 认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        // 设置底部技术字符串
        retweetedStr = countString(count: model.reposts_count, defaultString: "转发")
        commentStr = countString(count: model.comments_count, defaultString: "评论")
        likeStr = countString(count: model.attitudes_count, defaultString: "赞")
        
        // 计算配图视图大小
        picViewSize = calcPictureViewSize(count: status.pic_urls?.count ?? 0)
    }
    
    var description: String{
        return status.description
    }
    
    
    // 给定一个数字，返回对应的描述结果
    fileprivate func countString(count: Int, defaultString: String) -> String {
        
        if count == 0{
            return defaultString
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%02f万", Double(count)/10000)
        
    }
    
    // 计算指定数量的图片对应的配图视图的大小
    fileprivate func calcPictureViewSize(count: Int?) -> CGSize {
        
        if count == 0 || count == nil {
            return CGSize()
        }
        
        // 1. 计算配图视图的宽度
           // 常数准备
      
        
        // 2.计算高度
          // 1）根据count知道行数
        let  row = (count!-1) / 3 + 1
          // 2)根据行数算高度
        var height = WBStatusPictureViewOutterMargin
        height += CGFloat(row) * WBStatusPictureItemWidth
        height += CGFloat(row - 1)*WBStatusPictureViewInnerMargin
        
        return CGSize(width: WBStatusPicViewWidth, height: height)
    }
}










