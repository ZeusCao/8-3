//
//  WBNewFeatureView.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/5.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    class func newFeatureView() -> WBNewFeatureView {
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0]
        return v as! WBNewFeatureView
    }
    
    
    override func awakeFromNib() {
        // 添加四个图像视图
        let count = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<count {
            let imageName = "new_future_\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            // 设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(iv)
        }
        
        // 指定scrollView的尺寸
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.delegate = self
        // 隐藏按钮
        enterBtn.isHidden = true
    }
    
    
    // 进入微博
    @IBAction func enterStatus(_ sender: Any) {
        removeFromSuperview()
    }
    
}


extension WBNewFeatureView : UIScrollViewDelegate {
    
    // 结束减速的方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 滚动到最后一屏时，让视图移除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        // 判断是否是最后一页
        if page == scrollView.subviews.count {
            removeFromSuperview()
        }
        // 如果是倒数第二页显示按钮
        if page == scrollView.subviews.count - 1 {
            enterBtn.isHidden = false
        }
        else
        {
            enterBtn.isHidden = true
        }
        
    }
    
    // 欢迎按钮出来之后一滚动就要将其隐藏  该方法scrollView一滚动就调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 一旦滚动就隐藏按钮
        enterBtn.isHidden = true
        // 计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        // 设置分页控件
        pageController.currentPage = page
        // 分页控制器隐藏
        pageController.isHidden = (page == scrollView.subviews.count)
        
    }
    
    
}











