//
//  WBOAuthViewController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/29.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

// 通过webview加载新浪微博授权界面控制器
class WBOAuthViewController: UIViewController {

    fileprivate lazy var webview = UIWebView()
    
    override func loadView() {
        view = webview
        view.backgroundColor = UIColor.white
        
        webview.delegate = self
        // 设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target:self , action: #selector(close), isBackBtn: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // 加载授权界面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_url=\(WBRedirectURI)"
        // 1. 确定要访问的资源
        guard let url = URL(string: urlString)else {
            return
        }
        // 2. 建立请求
        let request = URLRequest(url: url)
        // 3. 加载请求
        webview.loadRequest(request)
        
    }

    
    // MARK---- 监听方法
    @objc fileprivate func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // 自动填充，webview的注入（直接通过js修改本地浏览器中缓存的页面内容）
    @objc fileprivate func autoFill() {
        // 准备js
        let js = "xxxxxxxxx"
        // 让webView直行js
        webview.stringByEvaluatingJavaScript(from: js)
    }
   
}

extension WBOAuthViewController: UIWebViewDelegate {
    
    
    /// webView将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webview
    ///   - request: 要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: 是否加载request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 确认思路
         // 1.如果请求地址包含http://baidu.com 不加载页面，否则要加载页面
         // 返回值是可选项 true false nil
        if request.url?.absoluteString.hasPrefix(WBRedirectURI) == false {
            return true
        }
        print("加载请求---\(String(describing: request.url?.absoluteString))")
        // query 是url中问号后面所有的部分
         print("加载请求---\(String(describing: request.url?.query))")
        // 2.从http://baidu.com 回调地址里面是否有code,如果有就授权成功，否则失败

        if  request.url?.query?.hasPrefix("code=") == false{
            print("取消授权")
            // 返回
            close()
            return false
        }
        
         // 3.从query中取出授权码
         // 代码走到此处,url中一定有查询字符串包含code
         let code = request.url?.query?.substring(from: "code=".endIndex)
        print("获取授权码\(code)")
        
        return false //(不用将百度页面取出来)
    }
}




























