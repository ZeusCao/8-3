//
//  WBMainController.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/8/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit
import SVProgressHUD
class WBMainController: UITabBarController {

    // 定时器
    fileprivate var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置新特性视图
        setupNewFeatureViews()
        
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        
        
        
       // 设置代理
        delegate = self as? UITabBarControllerDelegate
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    
    }
    deinit {
        // 销毁定时器
        timer?.invalidate()
    }
    
    // MARK ---- 用户登录通知的监听方法 ---
    @objc fileprivate func userLogin(n: Notification){
        
        print("用户通知")
        var deadline = DispatchTime.now()
        // 判断notification.object是否有值，如果有值提示用户重新登录
        if n.object != nil {
            // 修改指示器的渐变样式
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，需要重新登录")
            deadline = DispatchTime.now() + 2
        }
        
        //为了不让弹框一闪而过看不到,延迟执行
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            // 恢复设置
            SVProgressHUD.setDefaultMaskType(.clear)
            
            // 展现登录控制器, 通常会和UINavigationController连用，方便返回
            let vc = UINavigationController(rootViewController: WBOAuthViewController())
            
            self.present(vc, animated: true, completion: nil)

        }
        
    }
    
    
    
    /*
     - viewController中实现的方法
     - 使用代码控制设备的方向，可以在需要横屏的时候单独处理
     - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
     **/
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .portrait
    }
   
    
    // 添加按钮
    lazy var composeButton: UIButton = UIButton()
    
    // MARK --- 按钮的监听方法 ---
      // private 能够保证方法私有，仅在当前对象被访问
      // @objc 允许这个函数在运行时通过OC的消息机制被调用
     @objc func composeStatus() {
        print("撰写微博")
    }

}


// extension 类似于oc中的分类，在swift中还可以用来切分代码块
// 可以把相近功能的函数放在extension中
// 便于 维护代码
// 注意：和oc的分类一样，extension中不能定义属性，只能定义方法

// MARK------- 设置界面
extension WBMainController {
    // 设置添加按钮
   fileprivate func setupComposeButton() {
        composeButton.setImage(UIImage(named: "buttonAdd"), for: UIControlState(rawValue: 0))
        // 计算宽度
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count - 1// 为了防止点到容错点
        composeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        // oc中CGRectInset 正数向内缩进，负数向外扩散
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0) //（因为w－1 能够让其宽度变大，覆盖掉容错点）
       tabBar.addSubview(composeButton)
        
        // 添加撰写按钮的的点击方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置所有自控制器
     func  setupChildControllers() {
        
        // 现在很多的程序中界面的加载都依赖于网络的json
        // 从bundle加载配置的json
//        guard let path = Bundle.main.path(forResource: "demo.json", ofType: nil),
//            let data = NSData(contentsOfFile: path),
        // try？：弱try，如果解析成功就有值，否则为nil
        // try！：强try，如果解析成功就有值，否则崩溃
//            let array = try? JSONSerialization.jsonObject(with: data as Data , options: []) as? [String : AnyObject] else{
//                return
//        }
        
        
        let array   =  [
            ["clsName" : "WBHomeViewController" as AnyObject, "title" : "首页" as AnyObject, "imageName" : "113", "visitorInfo": ["imageName": "", "message": "关注一些人，回这里看看有什么惊喜"]],
            ["clsName" : "WBMessageViewController", "title" : "消息", "imageName" : "113", "visitorInfo": ["imageName": "visitordiscover_image_message", "message": "登陆后，别人评论你的微博，发给你的消息都会在这里收到通知"]],
            ["clsName" : ""],
            ["clsName" : "WBDiscoverViewController", "title" : "发现", "imageName" : "113", "visitorInfo": ["imageName": "visitordiscover_image_message", "message": "登陆后，最新最热的微博尽在掌握，不再会与实事潮流擦肩而过"]],
            ["clsName" : "WBProfileViewController", "title" : "我", "imageName" : "113" ,"visitorInfo": ["imageName": "visitordiscover_image_profile", "message": "登陆后，你的微博，相册，个人资料都会显示在这里，展示给被人砍"]]
        ]
        
        // 数组转化为json 序列化
        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
        (data as NSData).write(toFile: "/Users/Zeus/Desktop/demo.json", atomically: true)
        
        var arrayM = [UIViewController]()
        for dict in array {
            
            arrayM.append(controller(dict:dict as [String : AnyObject]))
        }
        
        viewControllers = arrayM

    }
    
    // 使用字典创建一个自控制器
    /// --parameter dict: 信息字典[clsName ,title, imageName]
    /// --returns: 子控制器
    fileprivate func controller(dict:[String : AnyObject]) -> UIViewController{
        
        // 1. 获取字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let visitorInfo = dict["visitorInfo"] as? [String : String],
        let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseController.Type
            //let cls = NSClassFromString(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""  + "." + clsName) as? UIViewController.Type
        //let cls  = NSClassFromString("模仿新浪微博.WBHomeViewController") as? UIViewController.Type

            else{
                            return UIViewController()
            }
        
        // 2.创建视图控制器
    
        let vc = cls.init()
        vc.title = title
        
        // 设置控制器的访客信息字典
        vc.visitorInfo = visitorInfo
        
        // 设置图像
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "103")?.withRenderingMode(.alwaysOriginal)
        
        // 设置tabbar的标题字体
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        // 大小
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)] , for:UIControlState(rawValue: 0))
        
        // 实例化导航控制器的时候，会调用push方法将rootVC压栈
        let nav = WBNavigationController(rootViewController: vc)
        return nav
        
    }
    
}


extension WBMainController {
    // 定义时钟
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
       }
    
    // 时钟触发方法
    @objc fileprivate func updateTimer(){
        
        // 如果没有登录则不用去触发时钟的方法
        if !WBNetworkManager.shared.userLogon {
            return
        }
        
        WBNetworkManager.shared.unreadCount { (count) in
        
             // 设置首页tabBarItem的badgeNumber
        self.tabBar.items?[0].badgeValue =   count > 0 ? "\(count)" : ""
        //self.tabBar.items?[0].badgeValue =   "9"

        
             // 设置app外层的badgeNumber,从ios8.0之后需要用户授权才能使用
        UIApplication.shared.applicationIconBadgeNumber = count
        }
    }


}

// 遵守代理
extension WBMainController: UITabBarControllerDelegate {
    
    /// 将要选择tabBarItem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: viewController 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到\(viewController)")
        
        // 1.获取控制器在数组中的索引
        let idx = childViewControllers.index(of: viewController)
        // 2.判断当前索引是否是首页，同时idx也是首页（即在首页又点击首页的按钮）
        if selectedIndex == 0 && idx == selectedIndex {
            print("点击首页")
            // 3. 让表格滚动到顶部
            // a. 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            vc.tableView?.setContentOffset(CGPoint(x: 0, y:-64), animated: true)
            // 4 刷新表格
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                vc.loadData()
            })
            
            // 5 清除tabItem的角标
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
        
        
        // 判断目标控制器是uiviewcontroller
        // 增加延迟，保证表格县滚动到顶部然后再进行刷新
        return !viewController.isMember(of: UIViewController.self) //避免点击到容错点
    }
    
}


// MARK ---设置视图新特性
extension WBMainController {
    fileprivate func setupNewFeatureViews() {
        
        // 0. 判断是否登录
        if !WBNetworkManager.shared.userLogon {
            return
        }
        
        // 1. 检查版本是否更新
        
        // 2.如果更新显示新特性，否则显示欢迎
        let v = isNewVersion ? WBNewFeatureView.newFeatureView() : WBWelcomView.welcomeView()
         //let v = WBNewFeatureView.newFeatureView()
        // 3添加视图
        v.frame = view.bounds
        view.addSubview(v)
    }
    
    // 计算型属性，构造函数，给属性分配空间
    fileprivate var isNewVersion: Bool{
        
        // 1. 取当前的版本号
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        // 2. 取保存在document目录下之前的版本号
        let path: String = ("version" as NSString).cz_appendDocumentDir()
        let sandBoxVersion = (try? String(contentsOfFile: path)) ?? ""
        // 3. 将版本号保存在沙盒中
        try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        // 4. 返回两个版本号的比较结果是否一致
        return currentVersion != sandBoxVersion
    }
    
    
}




















