//
//  LHMessageTableViewCell.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHMessageTableViewCell.h"
#define kIconViewWidth kWidthIphone7(6)

@implementation LHMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    _iconView = [[UIView alloc] init];
//    _iconView.bounds = CGRectMake(0, 0, kIconViewWidth, kIconViewWidth);
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = kWidthIphone7(3);
    [self.contentView addSubview:_iconView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_titleLabel];
    
    _desTitleLabel = [[UILabel alloc] init];
    _desTitleLabel.font = [UIFont appFontThree];
    _desTitleLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_desTitleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont appFontThree];
    _timeLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_timeLabel];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo((kBorderMargin-kIconViewWidth)/2.0);
        make.top.equalTo(kHeightIphone7(10));
        make.width.equalTo(kIconViewWidth);
        make.height.equalTo(kIconViewWidth);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kBorderMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(80));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_timeLabel.top);
        make.right.equalTo(_timeLabel.left).offset(-kWidthIphone7(5));
        make.height.equalTo(_timeLabel.height);
    }];
    
    [_desTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_titleLabel.bottom).offset(kHeightIphone7(5));
        make.right.equalTo(-kBorderMargin);
        make.height.equalTo(_timeLabel.height);
    }];
}

- (void)setModel:(LHMessageModel *)model{
    _model = model;
    if (_model.isWarning) {
        _iconView.backgroundColor = [UIColor redColor];
    }else{
        _iconView.backgroundColor = [UIColor greenColor];
    }
    _titleLabel.text = model.titleStr;
    _desTitleLabel.text = model.detailStr;
    _timeLabel.text = model.timeStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
