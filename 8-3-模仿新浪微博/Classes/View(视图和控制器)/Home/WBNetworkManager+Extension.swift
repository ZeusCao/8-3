//
//  WBNetworkManager+Extension.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/24.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation

// MARK --- 封装新浪微博的网络请求方法 ---
extension WBNetworkManager {
    

    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?,_ isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json?"
        
        // swift中int可以转换成AnyObject ,但是int64不行
        let param = ["since_id": "\(since_id)", "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        
        tokenRequset(URLString: urlString, parameters: nil) { (json, isSuccess) in
            // 从json中获取statuses数组（如果as失败，result为nil）
            let result = json?["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)

        }
    }
    
    // 返回微博的未读数量
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        
        guard let uid = uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid": uid]
        
        tokenRequset(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            print(json ?? "")
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        }
    }
    
    
    
}
