//
//  LHButton.h
//  ZQGJOwnerPort2
//
//  Created by 陈良辉 on 16/7/5.
//  Copyright © 2016年 Lianghui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonBlock)();

@interface LHButton : UIButton

@property (nonatomic,copy)buttonBlock tempBlock;

+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(buttonBlock)myBlock;
+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)color andBlock:(buttonBlock)myBlock;
+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName andBlock:(buttonBlock)myBlock;
+ (LHButton *)buttonWithFrame:(CGRect)frame imageName:(NSString *)imageName andBlock:(buttonBlock)myBlock;
+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)color textColor:(UIColor *)textColor andBlock:(buttonBlock)myBlock;

@end
