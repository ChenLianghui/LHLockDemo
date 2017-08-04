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
        self.backgroundColor = [UIColor backgroundColor];
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
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor grayLineColor];
    [self addSubview:lineView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.right).offset(kWidthIphone7(5));
        make.top.equalTo(_titleLabel.top);
        make.right.equalTo(-kBorderMargin);
        make.height.equalTo(_titleLabel.height);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_textfield);
        make.top.equalTo(_textfield.bottom);
        make.height.equalTo(1);
    }];
    
    if (![LHUtils isCurrentLanguageIsChinese]) {
        [_titleLabel updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(kWidthIphone7(130));
        }];
    }
}

@end
