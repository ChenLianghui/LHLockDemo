//
//  UIFont+App.m
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/27.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "UIFont+App.h"

@implementation UIFont (App)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [UIFont classSwizzle:@selector(systemFontOfSize:) with:@selector(appFontOfSize:)];
    });
}

+ (UIFont *)appFontOne {
    return [UIFont systemFontOfSize:kWidthIphone7(18)];
}

+ (UIFont *)appFontTwo {
    return [UIFont systemFontOfSize:kWidthIphone7(16)];
}

+ (UIFont *)appFontThree {
    return [UIFont systemFontOfSize:kWidthIphone7(14)];
}

+ (UIFont *)appFontFour {
    return [UIFont systemFontOfSize:kWidthIphone7(12)];
}

+ (UIFont *)appFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HiraKakuProN-W3" size:size];
}

@end
