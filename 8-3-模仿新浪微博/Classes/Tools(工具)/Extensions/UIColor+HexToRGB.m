//
//  UIColor+HexToRGB.m
//  Zeus封装基类
//
//  Created by Meetclass on 16/7/28.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "UIColor+HexToRGB.h"

@implementation UIColor (HexToRGB)

/*
 *UIColor之16进制数颜色值转换 RGB颜色值
 *比如：#FF6703、0XFF9900 等颜色字符串：
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *cString = [[hexString
                          stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return [UIColor clearColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat)r / 0xff)
                           green:((CGFloat)g / 0xff)
                            blue:((CGFloat)b / 0xff)
                           alpha:1.0f];

}



@end
