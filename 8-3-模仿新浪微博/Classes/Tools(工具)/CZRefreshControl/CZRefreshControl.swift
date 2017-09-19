//
//  CZRefreshControl.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/15.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

// 刷新控件
class CZRefreshControl: UIControl {

    // MARK --- 属性
    // 滚动视图的父视图应该适用于uitableview和uicollectionView
    fileprivate weak var scrollview: UIScrollView?
    
    // 构造函数
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    // xib开发
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // newSuperView： addsubview方法会调用
    // - 当添加到父视图的时候，newSuperView是父视图，当父视图被移除的时候newSuperView是nil
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 判断父视图的类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        // 记录父视图
        scrollview = sv
        
        // KVO监听父视图的contentOffset
        scrollview?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    
    // 所有kvo方法会调用此方法
    // 观察者模式，在不需要的时候都需要释放
       // --- 通知中心：如果不释放，什么也不会发生，但会造成内存泄漏，会有多次注册的可能
       // --- KVO： 如果不释放，会崩溃
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // consentOffset偏移量 .y 和contenInset（内偏距）的top有关
        print(scrollview?.contentOffset)
        
        guard let sv = scrollview else {
            return
        }
        
        // 初始高度应该为0
        let height = sv.contentInset.top + sv.contentOffset.y
        
        // 根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
    }
    
    
    // 本视图从superView上移除
    override func removeFromSuperview() {
        // superview还存在
        // 移除监听
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        // superView不存在
        
        
        
    }
    
    
   // 开始刷新
    func beginRefreshing() {
        print("开始刷新")
    }
   
   // 结束刷新
    func endRefreshing() {
        print("结束刷新")
    }
    
}

extension CZRefreshControl {
    fileprivate func setupUI() {
        backgroundColor = UIColor.orange
        
        
    }
}
