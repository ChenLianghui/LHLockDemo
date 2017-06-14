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
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15;
    return iconRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 45, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 45, 0);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    [super rightViewRectForBounds:bounds];
    CGRect rect = CGRectMake(self.bounds.size.width - 90, self.bounds.size.height/2-14, 90, 28);
    return rect;
}

@end
