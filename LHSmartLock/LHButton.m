//
//  LHButton.m
//  ZQGJOwnerPort2
//
//  Created by 陈良辉 on 16/7/5.
//  Copyright © 2016年 Lianghui Chen. All rights reserved.
//

#import "LHButton.h"

@implementation LHButton

+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(buttonBlock)myBlock{
    LHButton *button = [LHButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)color andBlock:(buttonBlock)myBlock{
    LHButton *button = [LHButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)color textColor:(UIColor *)textColor andBlock:(buttonBlock)myBlock{
    LHButton *button = [LHButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

+ (LHButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName andBlock:(buttonBlock)myBlock{
    LHButton *button = [LHButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

+ (LHButton *)buttonWithFrame:(CGRect)frame imageName:(NSString *)imageName andBlock:(buttonBlock)myBlock{
    LHButton *button = [LHButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

-(void)buttonBlockClick:(LHButton *)button{
    if (self.tempBlock) {
        self.tempBlock();
    }
}

@end
