//
//  WBUserAccount.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/31.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit
private let accountFile : NSString = "userAccount.json"
// 用户账户信息
class WBUserAccount: NSObject {

    // 用户令牌
    var access_token: String?
    // 用户代号
    var uid: String?
    // 用户昵称
    var screen_name: String?
    // 用户头像地址（大图）
    var avatar_large: String?
    
    
    // 过期时间，开发者五年，使用者三天
    var expires_in: TimeInterval = 0 {
        didSet{
            expiresdate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    // 过期日期
    var expiresdate: Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    func saveAccount() {
        // 1. 模型转字典
        var dict = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
         // 需要删除expires_in值
        dict.removeValue(forKey: "expires_in")
        // 2. 字典序列化 转data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let filePath = accountFile.cz_appendDocumentDir() else {
                return
        }
        // 3. 写入磁盘
       (data as NSData) .write(toFile: filePath, atomically: true)
        print("用户账户保存成功\(filePath)")
    }
    
    
    // 懒加载这个类的对象的时候会调用
    override init() {
       super.init()
        // 1.从磁盘加载板寸的文件
       guard let path = accountFile.cz_appendDocumentDir(),
        let data = NSData(contentsOfFile: path) ,
        let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject]else {
            return
        }
        // 2.使用字典设置属性值
        yy_modelSet(with: dict ?? [:])
        
        // 3. 判断token是否过期
        if expiresdate?.compare(Date()) != .orderedDescending {
            print("账户过期")
            // 清空token
            access_token = nil
            uid = nil
            // 删除账户文件
            try? FileManager.default.removeItem(atPath: path)
            
        }
    }
    
    
    
    
}
