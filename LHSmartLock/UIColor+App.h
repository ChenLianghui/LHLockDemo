//
//  UIColor+App.h
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/15.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)

//C1 whiteColor

//C2 背景色
+ (UIColor *)backgroundColor;
//C3 导航栏背景色
+ (UIColor *)naviBackColor;
//C4 应用主题色
+ (UIColor *)appThemeColor;
//C4-p 高亮主题色
+ (UIColor *)highlightThemeColor;
//C5 橘色按钮色
+ (UIColor *)orangeButtonColor;
//C5-p 高亮按钮色
+ (UIColor *)highlightButtonColor;
//T1 字体黑色
+ (UIColor *)blackFontColor;
//T2 字体深灰色
+ (UIColor *)darkGrayFontColor;
//T3 字体灰色
+ (UIColor *)grayFontColor;
//T4 字体浅灰色
+ (UIColor *)lightGrayFontColor;
//分隔线灰色
+ (UIColor *)grayLineColor;

@end
