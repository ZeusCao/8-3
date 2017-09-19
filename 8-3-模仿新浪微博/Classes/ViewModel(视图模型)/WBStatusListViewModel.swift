//
//  WBStatusListViewModel.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/25.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation
// swift中类可以不继承任何类，该类不继承任何类 创建文件的时候选swift
// 微博数据列表视图模型
// 父类的选择
/*    
 - 如果类需要使用KVC或者字典转模型框架设置对象值，类就需要继承NSobject
 - 如果类只是包装一些代码逻辑（写一些函数），可以不用任何父类，好处：更加轻量级
**/

// 负责微博的数据处理
// 1. 字典转模型
// 2. 下拉、上拉刷新数据处理

// 上拉刷新最大尝试次数
fileprivate let maxPullupTryTimes = 3

class WBStatusListViewModel {
    // 微博模型数组懒加载
    lazy var statusList = [WBStatusViewModel]()
    
    // 上拉刷新错误次数
    fileprivate var pullupErrorTimes = 0
    
    /// <#Description#>
    /// - pullUP 是否上拉标记
    /// - Parameter completion: 完成回调，网络请求是否成功
    /// since_id: 下拉刷新，取出数组中第一条微博的id
    //hasMorePullup : 是否有更多的上拉在家更多
    func loadStatus(pullUp: Bool , completion: @escaping (_ isSuccess: Bool, _ shouldrefresh: Bool) -> ()) {
        
        // 判断是否是上拉加载更多，同时检查刷新错误
        if pullUp && pullupErrorTimes > maxPullupTryTimes {
            completion(true, false)
            return;
        }
        
        
        /// since_id: 下拉刷新，取出数组中第一条微博的id
        // 如果是上拉since_id为0
        let since_id =  pullUp ? 0 : (self.statusList.first?.status.id ?? 0)
        
        
        // 取出数组最后一条微博的id
        let max_id = !pullUp ? 0 : (self.statusList.last?.status.id ?? 0)
        
        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 0、判断网络请求是否成功
            if !isSuccess {
                completion(false, false)
                return
            }
            
            // 1. 字典转模型 
              //1) 定义结果可变数组
            var array = [WBStatusViewModel]()
              //2) 便利服务器返回的字典数组，字典转模型
            for dict in list ?? [] {
                print( dict["pic_urls"])
                
                // a) 创建微博模型
                let status = WBStatus()
                 // 使用字典设置模型数值
                status.yy_modelSet(with: dict)
                
                // b) 使用微博模型创建微博视图模型
                let viewModel = WBStatusViewModel(model: status)
                
                // c） 将视图model添加到数组
                array.append(viewModel)
            }
            
            // 2.拼接数据
            if pullUp {
                // 上拉加载更多要把数据拼接在末尾
                self.statusList = self.statusList + array
            }
            else
            {
                // 下拉刷新应该将数组拼接在最前面
                self.statusList = array + self.statusList
            }
            
            
            // 判断上拉刷新的数据量
            if pullUp && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess, false)
            }
            
            // 3.完成回调
            completion(isSuccess, true)
        }
    }
}
