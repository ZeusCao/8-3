//
//  WBBaseController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

// 在swift中利用extension可以把函数按照功能分类管理，便于阅读和维护，注意： 1.extension中不能有属性， 2.extension中不能重写父类方法（重写子类方法是子类的职责，扩展是对类的扩展）


// 所有主控制器的基类控制器
class WBBaseController: UIViewController{
    
    // 表格视图- 如果没有用户登录，就不创建
    var tableView: UITableView?
    
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
        
    }
    
}


// MARR --- 设置界面
// 隔离代码
extension WBBaseController {
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

       setupNavigationBar()
       setupTableView()
    }
    
    // 设置导航条
    fileprivate func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将item设置给bar
        navigationBar.items = [navItem]
        
        // 设置navBar的渲染颜色
        navigationBar.barTintColor = UIColor.init(hexString: "0xf6f6f6")
        
        // 设置navBar的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
    }
    
    // 设置表格视图
    fileprivate func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源和代理，目的让子类直接实现数据源方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
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
    
}







