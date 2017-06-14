//
//  LHBaseTextfiledView.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseTextfiledView.h"

@interface LHBaseTextfiledView ()



@end

@implementation LHBaseTextfiledView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews{
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont appFontTwo];
    [self addSubview:_titleLabel];
    
    _textfield = [UITextField new];
    _textfield.font = [UIFont appFontTwo];
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_textfield];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kBorderMargin);
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.right).offset(kWidthIphone7(5));
        make.top.equalTo(_titleLabel.top);
        make.right.equalTo(-kBorderMargin);
        make.height.equalTo(_titleLabel.height);
    }];
}

@end
