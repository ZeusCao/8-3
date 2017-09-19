//
//  WBWelcomView.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/5.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit
import SDWebImage

// 欢迎视图
class WBWelcomView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!

    class func welcomeView() -> WBWelcomView {
        let nib = UINib(nibName: "WBWelcomView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0]
        return v as! WBWelcomView
    }
    
    //awakeFromNib 从xib或者storyboard加载完毕就会调用
    override func awakeFromNib() {
        
        guard let urlString = WBNetworkManager.shared.userAccount.avatar_large,
              let url = URL(string: urlString)
            else{
            return
        }
        
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default"))
        
        iconView.layer.cornerRadius = 42.5
        iconView.layer.masksToBounds = true
    }
    
    
    // 视图被添加到window上，表示视图已经显示,在此家动画
    override func didMoveToWindow() {
        
        super.didMoveToWindow()

        // layoutIfNeeded 会按照当前的约束直接更新控件位置 ，在此执行之后就是xib中布局的位置
        bottomCons.constant = bounds.size.height - 200
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { 
            
            // 更新约束
            self.layoutIfNeeded()
            
        }) { (_) in
            
            
            // 动画完成，执行第二个动画
            UIView.animate(withDuration: 1.0, animations: { 
                self.tipLabel.alpha = 1
            }, completion: { (_) in
                
                // 跳转界面
                self.removeFromSuperview()
                
            })
            
        }
    }
}
