//
//  WBNetworkManager.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/24.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit
// 直接导入框架的文件夹的名字即可
import AFNetworking

// swift的枚举支持任意数据类型
// switch 、enum在oc中都只是支持整数
enum WBHTTPMthod {
    case GET
    case POST
}


// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {

    // 单例 (静态区/常量/闭包)
      // 在第一次访问时执行闭包，并将结果保存在shared常量中
    static let shared = WBNetworkManager()
    
    // 访问令牌，所有的网络请求都基于此令牌（访问令牌有时限），默认用户是三天，过期之后服务器返回的状态码是403
    //var accessToken: String? = "2.00FJ2p9CwkU59C38bd621745oW6cKE"
    var accessToken: String? = "2.00A6tkOB0UjJZsf5f5f7d988glL4yB"
    
    // 用户的微博id
    var uid: String? = "5365823342"
    
    // 用户登录标记（计算型属性）
    var userLogon: Bool {
        return accessToken != nil
    }
    
    // 专门负责拼接网络请求的方法
    func tokenRequset(method: WBHTTPMthod = .GET ,URLString: String, parameters: [String : AnyObject]?, completion:@escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        // 处理token字典
          // 1.判断token是否为nil,为nil直接返回
        guard let token = accessToken else {
            // FIXME：发送通知（提示用户登录）
            
            print("没有token，需要登录")
            completion(nil, false)
            return
        }
        
        
          // 2.判断参数字典是否存在，如果为nil，应该新建一个字典
        var  parameters = parameters
        
        if parameters == nil {
            // 实例化字典
            parameters = [String: AnyObject]()
        }
          // 3.设置参数字典,此处一定有值，可以强行解包
          parameters!["accessToken"] = token as AnyObject
        
        // 调用requst方法发起真正的网络请求
        request(URLString: URLString, parameters: parameters, completion: completion)
        
    }
    
    
    /// 使用一个函数封装AFN的get和post
    ///
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json（字典、数组），是否成功]
    func request(method: WBHTTPMthod = .GET ,URLString: String, parameters: [String : AnyObject]?, completion:@escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        // 闭包：可以当做参数传递
        let success = { (task: URLSessionDataTask, json: Any?)->() in
            
            completion(json as AnyObject, true)
        }
        
        let failure = { (task: URLSessionDataTask?, error: Error)->() in
            
            // 针对403处理用户token过期
            if(task?.response as? HTTPURLResponse)?.statusCode == 403{
                print("token过期了")
                
                // FIXME：发送通知（本方法不知道被谁调用，谁接收到通知，谁处理）
            }
            
            print("网络错误\(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        else
        {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
}
