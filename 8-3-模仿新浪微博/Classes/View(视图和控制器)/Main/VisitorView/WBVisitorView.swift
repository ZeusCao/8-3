//
//  WBVisitorView.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/16.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {
    
    // 注册按钮
     lazy var registerButton: UIButton = UIButton(title: "注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    // 登录按钮
     lazy var loginButton: UIButton = UIButton(title: "登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    //访客视图的信息字典
    //didSet方法：在新的值被设定后立即调用(但是在初始化的时候赋值，是不调用didSet方法的)
    var visitorInfo:[String : String]?{
        didSet {
            // 1.取字典信息
            guard let imageName = visitorInfo?["imageName"],let message = visitorInfo?["message"]else{
                // 如果没有取到
                return
            }
            // 2. 设置消息
            tipLabel.text = message
            // 3. 设置图像
            // 首页不需要设置图像
            if imageName == "" {
                // 只有首页需要动画
                startAnimation()
                return
            }
            iconView.image = UIImage(named: imageName)
            // 其他访客视图不需要显示小房子和遮罩视图
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }
    

 // 访客视图--构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // 旋转图标动画
    fileprivate func startAnimation() {
       let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2*M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        // 完成之后不删除，如果iconView被释放掉，动画会一起被销毁
        anim.isRemovedOnCompletion = false
        // 让动画添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK --- 私有控件 ---
    // 懒加载属性只有在调用UIkit控件指定构造函数，其他都需要使用类型
    
    // 图像视图
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 灰色的背景视图
    fileprivate lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    // 小房子
    fileprivate lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示标签
    fileprivate lazy var tipLabel:UILabel = UILabel(title: "关注一些人，回这里看一看有什么惊喜关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
}




// 设置界面
extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor(hexString: "0xEDEDED")
       
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 文本居中
        tipLabel.textAlignment = .center
        
        // 2.取消autoresizing(autoresizing和autolayout是不能共存的，纯代码默认的是autoresizing，使用xib默认的是autolayout)
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3.自动布局
          // 1> 图像视图
          //iconView的X居中
        addConstraint(NSLayoutConstraint(item: iconView, attribute:.centerX, relatedBy:.equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
          //iconView的Y居中
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -60))
        
        // 2> 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1, constant: 0))
        
        // 3> 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute:.top, relatedBy: .equal, toItem: iconView, attribute:.bottom, multiplier: 1, constant: 20))
         // 指定宽度
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 236))
        
        // 4> 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute:.left, relatedBy: .equal, toItem: tipLabel, attribute:.left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute:.top, relatedBy: .equal, toItem: tipLabel, attribute:.bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        
        // 5> 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute:.right, relatedBy: .equal, toItem: tipLabel, attribute:.right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute:.top, relatedBy: .equal, toItem: tipLabel, attribute:.bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: registerButton, attribute: .width, multiplier: 1, constant: 0))

        // 灰色背景图像
        // view: 定义VFL中控件名称和实际名称的映射关系
        // matrics: 定义VFL中（）中指定的常数映射关系(可以换成注释掉的写法)
        let viewDict = ["maskIconView" : maskIconView, "registerButton" : registerButton] as [String : Any]
        let matrics = ["spacing": -20]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(-20)-[registerButton]", options: [], metrics: nil, views: viewDict))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(spacing)]-[registerButton]", options: [], metrics:matrics, views: viewDict))
        
        
    }
}
