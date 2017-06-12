//
//  LHTextField.m
//  ZQGJOwnerPort2
//
//  Created by 陈良辉 on 16/6/27.
//  Copyright © 2016年 Lianghui Chen. All rights reserved.
//

#import "LHTextField.h"

@implementation LHTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    [super leftViewRectForBounds:bounds];
    CGRect rect = CGRectMake(15, 5, 30, 30);
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    [super rightViewRectForBounds:bounds];
    CGRect rect = CGRectMake(self.bounds.size.width - 90, self.bounds.size.height/2-14, 90, 28);
    return rect;
}

@end
