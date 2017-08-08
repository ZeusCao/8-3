//
//  DateManager.h
//  Zeus封装基类
//
//  Created by Meetclass on 16/8/31.
//  Copyright © 2016年 Zeus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DateManager : NSObject

//获取系统当前日期
+ (NSString *)systemYear;
+ (NSString *)systemMonth;
+ (NSString *)systemDay;
+ (NSString *)systemDateWithCutString:(NSArray *)cutStrArr;

//获取系统时间戳
+ (NSString *)getSystemTimeString;
+ (NSString *)getSystemTimeString8Hours;

//年月日转时间戳
+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

//date转时间戳
+ (NSString *)getTimeStringWithDate:(NSDate *)date;

//时间戳转date
+ (NSDate *)getDateWithTimeString:(NSString *)timeStr;

//date用str输出
+ (NSString *)getDateStringWithDate:(NSDate *)date;
#pragma mark --- long类型时间戳转化为时间的字符串 ---(14位的长整型时间戳)
+ (NSString *)getDateStringWithLongTimeString:(long)timeStamp;

//获取系统时间精确到秒
+ (NSString *)getSystemTime;//非本时区
+ (NSString *)getSystemTimeWith8Hours;//本时区

//date转为本时区date
+ (NSDate *)getTootTimeZoneWithAnydate:(NSDate *)date;

//60秒倒计时方法
+ (void)getValidateCodeWithPerformer:(id)sender completion:(void (^)(NSString *strTime))starting completion:(void (^)(void))ending;




@end
