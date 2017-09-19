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
    //static let shared = WBNetworkManager()
    
    static let shared : WBNetworkManager = {
        
        // 实例化对象
        let instence = WBNetworkManager()
        // 设置响应反序列化支持的类型
        instence.responseSerializer.acceptableContentTypes?.insert("text/plain")
        // 返回对象
        return instence
        
    }()
    
    // 用户账户的懒加载属性
    lazy var userAccount = WBUserAccount()
    
    // 用户登录标记（计算型属性）
    var userLogon: Bool {
        return userAccount.access_token != nil
    }
    
    // 专门负责拼接网络请求的方法
    func tokenRequset(method: WBHTTPMthod = .GET ,URLString: String, parameters: [String : AnyObject]?, completion:@escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        // 处理token字典
          // 1.判断token是否为nil,为nil直接返回
        guard let token = userAccount.access_token else {
            // 发送通知（提示用户登录）
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
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
          parameters!["access_token"] = token as AnyObject
        
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
                
                // ：发送通知（本方法不知道被谁调用，谁接收到通知，谁处理）
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
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
