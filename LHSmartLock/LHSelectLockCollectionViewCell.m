//
//  LHSelectLockCollectionViewCell.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHSelectLockCollectionViewCell.h"

@implementation LHSelectLockCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initSubViews{
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont appFontFour];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _batteryImageView = [UIImageView new];
    [self.contentView addSubview:_batteryImageView];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.centerX);
        make.centerY.equalTo(self.contentView.centerY).offset(-10);
        make.width.equalTo(self.contentView.width).dividedBy(3);
        make.height.equalTo(_iconImageView.width).multipliedBy(4/3.0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom).offset(kHeightIphone7(8));
        make.centerX.equalTo(self.contentView.centerX);
        make.width.equalTo(self.contentView.width);
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_batteryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kHeightIphone7(5));
        make.right.equalTo(-kWidthIphone7(5));
        make.width.equalTo(kWidthIphone7(20));
        make.height.equalTo(kHeightIphone7(8));
    }];
}

- (void)setModel:(LHLockModel *)model{
    _model = model;
    _titleLabel.text = model.lockName;
    if ([model.status isEqualToString:@"close"]) {
        _iconImageView.image = [UIImage imageNamed:@"lock_gray"];
    }else{
        _iconImageView.image = [UIImage imageNamed:@"unlock_gray"];
    }
    if ([model.power isEqualToString:@"low"]) {
        _batteryImageView.image = [UIImage imageNamed:@"buttery1"];
    }else if ([model.power isEqualToString:@"middle"]){
        _batteryImageView.image = [UIImage imageNamed:@"buttery3"];
    }else if ([model.power isEqualToString:@"high"]){
        _batteryImageView.image = [UIImage imageNamed:@"buttery5"];
    }else{
        //unknow
        
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    if (isSelected) {
//        if (_model.isLock) {
//            _iconImageView.image = [UIImage imageNamed:@"lock_white"];
//        }else{
//            _iconImageView.image = [UIImage imageNamed:@"unlock_white"];
//        }
//        switch (_model.electricNumber) {
//            case 1:
//                _batteryImageView.image = [UIImage imageNamed:@"buttery1_selected"];
//                break;
//            case 3:
//                _batteryImageView.image = [UIImage imageNamed:@"buttery3_selected"];
//                break;
//            case 5:
//                _batteryImageView.image = [UIImage imageNamed:@"buttery5_selected"];
//                break;
//            default:
//                break;
//        }
        if ([_model.status isEqualToString:@"close"]) {
            _iconImageView.image = [UIImage imageNamed:@"lock_white"];
        }else{
            _iconImageView.image = [UIImage imageNamed:@"unlock_white"];
        }
        if ([_model.power isEqualToString:@"low"]) {
            _batteryImageView.image = [UIImage imageNamed:@"buttery1_selected"];
        }else if ([_model.power isEqualToString:@"middle"]){
            _batteryImageView.image = [UIImage imageNamed:@"buttery3_selected"];
        }else if ([_model.power isEqualToString:@"high"]){
            _batteryImageView.image = [UIImage imageNamed:@"buttery5_selected"];
        }else{
            //unknow
            
        }
        _titleLabel.textColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor appThemeColor];
    }else{
        if ([_model.status isEqualToString:@"close"]) {
            _iconImageView.image = [UIImage imageNamed:@"lock_gray"];
        }else{
            _iconImageView.image = [UIImage imageNamed:@"unlock_gray"];
        }
        if ([_model.power isEqualToString:@"low"]) {
            _batteryImageView.image = [UIImage imageNamed:@"buttery1"];
        }else if ([_model.power isEqualToString:@"middle"]){
            _batteryImageView.image = [UIImage imageNamed:@"buttery3"];
        }else if ([_model.power isEqualToString:@"high"]){
            _batteryImageView.image = [UIImage imageNamed:@"buttery5"];
        }else{
            //unknow
            
        }
//        if (_model.isLock) {
//            _iconImageView.image = [UIImage imageNamed:@"lock_gray"];
//        }else{
//            _iconImageView.image = [UIImage imageNamed:@"unlock_gray"];
//        }
//        switch (_model.electricNumber) {
//            case 1:
//                _batteryImageView.image = [UIImage imageNamed:@"buttery1"];
//                break;
//            case 3:
//                _batteryImageView.image = [UIImage imageNamed:@"buttery3"];
//                break;
//            case 5:
//                _batteryImageView.image = [UIImage imageNamed:@"buttery5"];
//                break;
//            default:
//                break;
//        }
        _titleLabel.textColor = [UIColor blackColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setIsEmpty:(BOOL)isEmpty{
    _isEmpty = isEmpty;
    _iconImageView.image = [UIImage imageNamed:@"addLock"];
    _titleLabel.text = NSLocalizedString(@"添加密码锁", nil);
    _titleLabel.textColor = [UIColor whiteColor];
    _batteryImageView.image = [UIImage imageNamed:@""];
//    _batteryImageView.image = [UIImage imageNamed:@""];
    self.contentView.backgroundColor = [UIColor appThemeColor];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
