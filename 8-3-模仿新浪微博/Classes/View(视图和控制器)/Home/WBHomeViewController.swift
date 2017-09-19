//
//  WBHomeViewController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

// 定义全局常量，尽量使用private，否则到处都可以访问
private let cellId = "cellId"

class WBHomeViewController: WBBaseController {
    
    // 微博数据数组
    fileprivate lazy var listViewModel = WBStatusListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 加载数据
    override func loadData() {

        listViewModel.loadStatus(pullUp: isPullup) { (isSuccess, shouldrefresh) in
            print("加载数据结束")
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            // 恢复上拉刷新标记
            self.isPullup = false
            
            // 刷新表格
            if shouldrefresh {
                self.tableView?.reloadData()
            }
            
        }
        

        
    }
    

    @objc fileprivate func showFriends(){
        print(#function)
        
        let vc = WBDemoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK -- 设置界面
extension WBHomeViewController{
    
    // 重写父类的方法
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏
        // 无法高亮
        // navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action:#selector(showFriends), isBackBtn: false)
        
        // 注册原型cell
        tableView?.register(UINib(nibName: "WBStatusNormalCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        // 设置行高
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        
        
        setupNaviTitle()
    }
    
    // 设置导航栏标题
    fileprivate func setupNaviTitle() {
        let title = WBNetworkManager.shared.userAccount.screen_name
        let button = WBTitleButton(title: title ?? "")
        navItem.titleView = button
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    @objc func clickTitleButton(btn:UIButton) {
        // 设置选中状态
        btn.isSelected = !btn.isSelected
    }
}

// MARK --- 表格数据源方法 ---
extension WBHomeViewController {
    
    // 表格的数据源方法，不需要super
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WBStatusCell
        
        tableView.separatorStyle = .none
        
        // 2 设置cell
        let vm = listViewModel.statusList[indexPath.row]
        cell.viewModel = vm
                
        // 3 返回cell
        return cell
    }
}













