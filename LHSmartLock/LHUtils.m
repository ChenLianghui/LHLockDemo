//
//  LHUtils.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHUtils.h"

@implementation LHUtils

+ (BOOL)isEmptyStr:(NSString*)str {
    if(str != nil && [str isKindOfClass:[NSString class]] && str.length > 0)
    return NO;
    else
    return YES;
}
  
+ (BOOL)verifyMobile:(NSString *)mobile {
    if (mobile == nil || mobile.length == 0) return NO;
    NSString    *regex = @"^(\\+86|)(|0)1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:mobile];
}

+ (BOOL)isCurrentLanguageIsChinese{
    NSString *udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    if ([udfLanguageCode isEqualToString:@"zh-Hans-US"]) {
        return YES;
    }
    return NO;
}

+ (void)callTelephoneWithString:(NSString *)mobile{
    NSString *phone = [NSString stringWithFormat:@"telprompt://%@",mobile];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phone]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
    }
}

+ (NSString *)timeSwitchTimestamp:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:dateStr];
    double timeSp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.f",timeSp];
}

+ (NSString *)timeStampSwitchDateStr:(NSString *)stampStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[stampStr doubleValue]/1000.0];
    return [formatter stringFromDate:date];
}

+ (NSString *)timeStampSwitchMonthTimeStr:(NSString *)stampStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[stampStr doubleValue]/1000.0];
    return [formatter stringFromDate:date];
}

@end
