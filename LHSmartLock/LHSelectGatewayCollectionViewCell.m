//
//  LHSelectGatewayCollectionViewCell.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHSelectGatewayCollectionViewCell.h"

@interface LHSelectGatewayCollectionViewCell ()


@end

@implementation LHSelectGatewayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    _iconImageView = [UIImageView new];
    
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont appFontThree];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.centerX);
        make.centerY.equalTo(self.contentView.centerY).offset(-kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(80));
        make.height.equalTo(kWidthIphone7(80));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom).offset(kHeightIphone7(10));
        make.centerX.equalTo(self.contentView.centerX);
        make.width.equalTo(self.contentView.width);
        make.height.equalTo(kHeightIphone7(20));
    }];
}

- (void)setModel:(LHGatewayModel *)model{
    _model = model;
    _titleLabel.text = model.gatewayName;
    _titleLabel.textColor = [UIColor appThemeColor];
    _iconImageView.image = [UIImage imageNamed:@"gateway_open"];
}

@end
