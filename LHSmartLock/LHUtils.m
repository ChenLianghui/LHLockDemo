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

@end
