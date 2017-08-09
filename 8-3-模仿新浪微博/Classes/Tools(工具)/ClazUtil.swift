//
//  ClazUtil.swift
//  Webo10
//
//  Created by ChengXiwu on 2017/7/29.
//  Copyright © 2017年 ChengXiwu. All rights reserved.
//

import UIKit

/// 静态工具类,使用static修饰的静态方法不能被子类重写,使用class修饰的类方法可以被子类重写
class ClazUtil {
    
    
    // 命名空间
    static let CLZ_NAMESPACE = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

    
    // 根据类名字符串反射得到类
    static func invoke(clzName: String)->AnyClass? {
        return NSClassFromString(CLZ_NAMESPACE + "." + clzName)
    }
    
    // 获取对象所有属性
    static func getObjectPropertys(obj: Any)->[Mirror.Child] {
        return Mirror(reflecting: obj).children.filter { $0.label != nil }
    }
    
    // 获取对象所有属性名称,返回数组
    static func getObjectFields(obj: Any)->[String] {
        
        var keys = [String]()
        let propertys = getObjectPropertys(obj: obj)
        for p in propertys {
            keys.append(p.label!)
        }
        
        return keys
    }
    
    // 重新设置对象描述信息
    static func resetDescription(obj: NSObject)->String {
        let keys = getObjectFields(obj: obj)
        return obj.dictionaryWithValues(forKeys: keys).description
    }
    
    
    // 归档 - 在把当前对象保存到磁盘前,将对象编码成二进制数据,与网络的序列化概念类似
    static func encode(with aCoder: NSCoder, obj: NSObject) {
        // 获取所有属性
        let propertys = getObjectPropertys(obj: obj)
        // 对所有属性归档保存
        for p in propertys {
            aCoder.encode(p.value, forKey: p.label!)
        }
        
    }
    
    // 解档 - 从磁盘加载二进制文件,转换成对象时调用,与网络的反序列化类似
    // 没有继承性,所有对象只能解档出当前的类对象
    static func decode(coder aDecoder: NSCoder, obj: NSObject) {        
        let propertys = getObjectPropertys(obj: obj)
        for p in propertys {
            obj.setValue(aDecoder.decodeObject(forKey: p.label!), forKey: p.label!)
        }
    }
    
    
}
