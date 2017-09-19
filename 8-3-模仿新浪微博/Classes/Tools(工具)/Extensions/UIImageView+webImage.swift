//
//  UIImageView+webImage.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/8.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation
import SDWebImage

// 隔离sdwebimage设置图像函数
extension UIImageView {
    
    func  cz_setImage(urlString: String?,placeholderImage: UIImage?, isAvatar: Bool = false) {
        
        // 处理URL
        guard let urlString = urlString,
        let url = URL(string: urlString)else {
            image = placeholderImage
            return
        }
        
        // 防止里面会出现循环引用加[weak self]
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self](image, _, _, _) in
           
            // 判断是否是设置头像
            if isAvatar {
                // 设置圆角
              self?.image = image?.cz_avatarImage(size: self?.bounds.size)
            }
            
        }
    }
    
}
