//
//  DateManager.h
//  Zeus封装基类
//
//  Created by Meetclass on 16/8/31.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager

#pragma mark - 获取系统当前时间 ---年---
+ (NSString *)systemYear
{
    //获得系统时间年
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger yearNow = [conponent year];
    
    return [NSString stringWithFormat:@"%ld", (long)yearNow];
}

#pragma mark - 获取系统当前时间 ---月----
+ (NSString *)systemMonth
{
    //获得系统时间月
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger monthNow = [conponent month];
    
    return [NSString stringWithFormat:@"%ld", (long)monthNow];
}

#pragma mark - 获取系统当前时间 ---天----
+ (NSString *)systemDay
{
    //获得系统时间日
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger dayNow = [conponent day];
    
    return [NSString stringWithFormat:@"%ld", (long)dayNow];
}


+ (NSString *)systemDateWithCutString:(NSArray *)cutStrArr
{
    //获得系统时间日
    NSDate *  senddate=[NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger dayNow = [conponent day];
    NSInteger monthNow = [conponent month];
    NSInteger yearNow = [conponent year];
    
    if (cutStrArr.count == 3) {
        return [NSString stringWithFormat:@"%ld%@%ld%@%ld%@", (long)yearNow, cutStrArr[0],(long)monthNow, cutStrArr[1], (long)dayNow, cutStrArr[2]];
    } else {
        return [NSString stringWithFormat:@"%ld%@%ld%@%ld%@", (long)yearNow, @"-",(long)monthNow, @"-", (long)dayNow, @"-"];
    }
}



#pragma mark --- 获取系统时间戳 ---非本时区 --
+ (NSString *)getSystemTimeString
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", time];
    
    return timeString;
}


#pragma mark --- 获取系统时间戳 ---本时区 --
+ (NSString *)getSystemTimeString8Hours
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] + 3600 * 8;
    NSString *timeString = [NSString stringWithFormat:@"%f", time];
    
    return timeString;
}



#pragma mark --- 年月日转化为 时间戳 ---
+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    //转时间戳
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, (long)month, (long)day];
    //任何时间string转date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[dateFormatter dateFromString:dateString];
    //时间date转时间戳
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}


#pragma mark --- 年月日 时分秒 转化为时间戳 ----
+ (NSString *)getTimeStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    //转时间戳
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld  %ld-%ld-%ld", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
    //任何时间string转date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-M-d  H-m-s"];
    NSDate *date=[dateFormatter dateFromString:dateString];
    //时间date转时间戳
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}


#pragma mark --- date转时间戳 ---
+ (NSString *)getTimeStringWithDate:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970] + 3600 * 8;
    return [NSString stringWithFormat:@"%.0f", time];
}

#pragma mark --- 时间戳转date ---
+ (NSDate *)getDateWithTimeString:(NSString *)timeStr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd  HH-mm-ss"];
    NSDate *date = [formatter dateFromString:timeStr];
    
    return date;
}

#pragma mark --- long类型时间戳转化为时间的字符串 ---(14位的长整型时间戳)
+ (NSString *)getDateStringWithLongTimeString:(long)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


#pragma mark --- NSDate用string形式输出
+ (NSString *)getDateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}


#pragma mark --- 获取时间精确到秒（非本时区）---
+ (NSString *)getSystemTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}

#pragma mark --- 获取时间精确到秒（本时区）---
+ (NSString *)getSystemTimeWith8Hours
{
    NSDate *  senddate=[NSDate date];
    
    NSTimeInterval time = [senddate timeIntervalSince1970] + 3600 * 8;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:confromTimesp];
    
    return morelocationString;
}


#pragma mark --- date转化为本时区date ---
+ (NSDate *)getTootTimeZoneWithAnydate:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970] + 3600 * 8;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    
    return confromTimesp;
}


#pragma mark --- 60秒倒计时方法 ---
+ (void)getValidateCodeWithPerformer:(id)sender completion:(void (^)(NSString *))starting completion:(void (^)(void))ending
{
    //倒计时
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        timeout--;
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置(倒计时结束)
                ending();
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"剩余%.2d秒", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置(倒计时中)
                starting(strTime);
                
            });
        }
    });
    dispatch_resume(_timer);
}






@end
