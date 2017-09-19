//
//  WBStatusCell.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/7.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    var viewModel: WBStatusViewModel? {
        didSet{
            // 微博文本
            statusLabel?.text = viewModel?.status.text
            // 姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            // 设置会员图标
            memberIconView.image = viewModel?.memberIcon
            // 认证图标
            vipIconView.image = viewModel?.vipIcon
            // 用户头像
            iconView.cz_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            // 底部工具栏
            toolBar.viewModel = viewModel // 此方法调用类中didSet方法
            
            // 测试修改配图视图的高度
            pictureView.heightCons.constant = viewModel?.picViewSize.height ?? 0
            
            // 设置配置视图的URL数据
//            if (viewModel?.status.pic_urls?.count)! > 4 {
//                var picUrls = viewModel?.status.pic_urls
//                picUrls?.removeSubrange(((picUrls?.startIndex)! + 4)..<(picUrls?.endIndex)!)
//            }
//            else
//            {
                pictureView.urls = viewModel?.status.pic_urls
//            }
            
        }
    }
    
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var memberIconView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var vipIconView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var toolBar: WBStatusToolBar!
    
    // 配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    
    @IBOutlet weak var picTopCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
