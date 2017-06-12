//
//  UIColor+App.m
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/15.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "UIColor+App.h"

@implementation UIColor (App)
//背景色
+ (UIColor *)backgroundColor {
    return [UIColor colorWithHex:0xf8f9fa];
}

//导航栏背景色
+ (UIColor *)naviBackColor {
    return [UIColor colorWithHex:0xf5f5f5];
}

//应用主题色
+ (UIColor *)appThemeColor {
    return [UIColor colorWithHex:0x30a6fa];
}

//高亮主题色
+ (UIColor *)highlightThemeColor {
    return [UIColor colorWithHex:0x0180da];
}

//橘色按钮色
+ (UIColor *)orangeButtonColor {
    return [UIColor colorWithHex:0xffa600];
}

//高亮按钮色
+ (UIColor *)highlightButtonColor {
    return [UIColor colorWithHex:0xef8600];
}

//字体黑色
+ (UIColor *)blackFontColor {
    return [UIColor colorWithHex:0x323232];
}

//字体深灰色
+ (UIColor *)darkGrayFontColor {
    return [UIColor colorWithHex:0x787878];
}

//字体灰色
+ (UIColor *)grayFontColor {
    return [UIColor colorWithHex:0x969696];
}

//字体浅灰色
+ (UIColor *)lightGrayFontColor {
    return [UIColor colorWithHex:0xc8c8c8];
}

//分隔线灰色
+ (UIColor *)grayLineColor {
    return [UIColor colorWithHex:0xe1e1e1];
}

//分隔线深色（边栏）
+ (UIColor *)darkLineColor {
    return [UIColor colorWithHex:0x3d4457];
}

@end
