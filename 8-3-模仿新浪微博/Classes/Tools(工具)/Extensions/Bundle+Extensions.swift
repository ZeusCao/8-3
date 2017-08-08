//
//  Bundle+Extensions.swift
//  8-1-反射机制
//
//  Created by Zeus on 2017/8/2.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import Foundation


extension Bundle{
    
    // 返回命名空间的字符串
//    func nameSpace() -> String{
//      return  Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//    }
    
    //也可以写成计算性属性
    //
    var nameSpace: String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }

    
}
