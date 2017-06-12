//
//  CommonDefine.h
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define MR_SHORTHAND
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

//导入头文件
#import "AFNetworking.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "LHUtils.h"
#import "UIFont+App.h"
#import "UIImage+Extents.h"
#import "NSObject+Swizzle.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <objc/runtime.h>
//屏幕尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenScale ([UIScreen mainScreen].scale)
#define kScreenRatio (kScreenWidth / 320)
#define kLineWidth (1.0f/kScreenScale)
#define kBorderMargin kSizeFrom750(35)
#define kContentMargin kSizeFrom750(15)

#define kWidthIphone7(x) (x * kScreenWidth / 375)
#define kHeightIphone7(x) (x * kScreenHeight / 667)
//根据720分辨率计算size
#define kSizeFrom720(x) (x * kScreenRatio * 320 / 720)

#define kSizeFrom750(x) (NSInteger)(x * kScreenRatio * 320 / 750)


#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#endif /* CommonDefine_h */
