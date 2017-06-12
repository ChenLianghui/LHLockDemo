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
    
@end
