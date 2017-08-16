//
//  UIColor+HexToRGB.h
//  Zeus封装基类
//
//  Created by Meetclass on 16/7/28.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexToRGB)


/*
 *UIColor之16进制数颜色值转换 RGB颜色值
 *比如：#FF6703、0XFF9900 等颜色字符串：
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;




@end
