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
        
        // 用网络工具加载微博数据
//        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json?"
//        let params = ["access_token": "2.00FJ2p9CwkU59C38bd621745oW6cKE"]
        
        
//        WBNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
//            print(json)
//        }) { (_, error) in
//            print("网络请求失败\(error)")
//        }
        
        
//        WBNetworkManager.shared.request(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
//            print(json)
//        }
        
//        WBNetworkManager.shared.statusList(completion: { (list, isSuccess) in
//            // 字典转模型，绑定表格数据
//            print(list ?? "")
//
//        })
//       // print("开始加载数据\(WBNetworkManager.shared)")
//        // 模拟延时加载数据
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) //延迟一秒
//        {
//            for i in 0..<15 {
//                
//                // 如果是上拉加载更多，将数据追加到底部
//                if self.isPullup {
//                    self.statusList.append("上拉\(i)")
//                }
//                else
//                {
//                    // 将数据插入到数组的顶层
//                    self.statusList.insert(i.description, at: 0)
//                }                
//            }
//            print("加载数据结束")
//            // 结束刷新控件
//            self.refreshControl?.endRefreshing()
//            // 恢复上拉刷新标记
//            self.isPullup = false
//            self.tableView?.reloadData()
//        }
        
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
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        // 2 设置cell
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        // 3 返回cell
        return cell
    }
}













