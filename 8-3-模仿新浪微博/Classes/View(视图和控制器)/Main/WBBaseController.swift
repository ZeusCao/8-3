//
//  WBBaseController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

// 在swift中利用extension可以把函数按照功能分类管理，便于阅读和维护，注意： 1.extension中不能有属性， 2.extension中不能重写父类本类的方法【不包括扩展方法】（重写子类方法是子类的职责，扩展是对类的扩展）


// 所有主控制器的基类控制器
class WBBaseController: UIViewController{
    
    // 用户登录状态
    var userLogon = false
    
    // 访客视图信息字典
    var visitorInfo: [String : String]?
    
    // 表格视图- 如果没有用户登录，就不创建
    var tableView: UITableView?
    // 刷新控件
    var refreshControl: UIRefreshControl?
    
    // 作为上拉加载更多的标记
    var isPullup = false
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
    // 自定义的导航条目
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    // 重写title的set方法
    override var title: String? {
        didSet{
            navItem.title = title
        }
    }
    
    // 加载数据 -- 具体的方法由子类负责
    func loadData() {
        // 如果子类不实现该方法，则默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
    
}

// MARK--- 访客视图监听方法 ---
extension WBBaseController {
    @objc fileprivate func login() {
        print("用户登录界面")
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    @objc fileprivate func register() {
        print("用户注册界面")
    }
    
}




// MARR --- 设置界面
// 隔离代码
extension WBBaseController {
    
   fileprivate  func setupUI() {
        view.backgroundColor = UIColor.white
        
        // 取消自动缩进(如果隐藏了导航栏会缩进20个点)
        automaticallyAdjustsScrollViewInsets = false

       setupNavigationBar()
        userLogon ? setupTableView() : setupVisitorView()
        //WBNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    // 设置导航条
    fileprivate func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将item设置给bar
        navigationBar.items = [navItem]
        
        // 设置navBar的整个背景渲染颜色
        navigationBar.barTintColor = UIColor.init(hexString: "0xf6f6f6")
        
        // 设置navBar的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        
        // 设置上面系统按钮的颜色
        navigationBar.tintColor = UIColor.orange
    }
    
    
    // 设置表格视图 (子类重写此方法，因为子类不需要关心用户登陆之前的逻辑)
     func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源和代理，目的让子类直接实现数据源方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 0, right: 0)
        
        
        // 设置刷新控件 
        // 1 实例化刷新控件
        refreshControl = UIRefreshControl()
        // 2 添加到表格视图
        tableView?.addSubview(refreshControl!)
        // 3 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    // 设置访客视图，用户没有登录时呈现
    fileprivate func setupVisitorView() {
        let visitorView = WBVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        // 设置访客视图信息
        visitorView.visitorInfo = visitorInfo
        
        // 添加访客视图的监听方法
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        // 设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
            navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    
    
    }
    
}


// MARK --- 代理方法
extension WBBaseController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现，子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 只是保证没有语法错误
        return UITableViewCell()
    }
    
    // 将要显示cell
    // 在现实最后一行的时候做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // <1> 判断indexpath是否是最后一行
          // 1 取出row
          let row = indexPath.row
          // 2 取出section
          let section = tableView.numberOfSections - 1
        
          if row < 0 || section < 0 {
             return
          }
        
          // 行数
          let count = tableView.numberOfRows(inSection: section)
          // 如果是最后一行同时没有开始上拉加载更多
          if row == count - 1 && isPullup == false {
             print("上拉刷新")
            isPullup = true
            
            // 开始刷新
            loadData()
            
          }
    }
    
}







