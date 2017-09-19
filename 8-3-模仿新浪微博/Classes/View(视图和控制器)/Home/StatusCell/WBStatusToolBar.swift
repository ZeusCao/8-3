//
//  WBStatusToolBar.swift
//  8-3-模仿新浪微博
//
//  Created by Zeus on 2017/9/8.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {
    
    var viewModel: WBStatusViewModel? {
        didSet{
            retweetedButton.setTitle(viewModel?.retweetedStr, for: .normal)
            commentButton.setTitle(viewModel?.commentStr, for: .normal)
            likeButton.setTitle(viewModel?.likeStr, for: .normal)
        }
    }
    

    @IBOutlet weak var retweetedButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!

    
    
}
