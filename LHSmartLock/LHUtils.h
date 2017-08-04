//
//  LHUtils.h
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ToastTop = 0,
    ToastCenter,
    ToastBottom,
} ToastPosition;

@interface LHUtils : NSObject

+ (BOOL)isEmptyStr:(NSString*)str;
    
+ (BOOL)verifyMobile:(NSString *)mobile;

+ (BOOL)isCurrentLanguageIsChinese;

//拨打电话
+(void)callTelephoneWithString:(NSString *)mobile;

//日期字符串转出时间戳
+ (NSString *)timeSwitchTimestamp:(NSString *)dateStr;

//时间戳转出日期字符串
+ (NSString *)timeStampSwitchDateStr:(NSString *)stampStr;

//时间戳转出日期时间字符串
+ (NSString *)timeStampSwitchMonthTimeStr:(NSString *)stampStr;
    
@end
