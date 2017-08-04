//
//  LHRecordListTableViewCell.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHRecordListTableViewCell.h"

@implementation LHRecordListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.contentView.backgroundColor = [UIColor backgroundColor];
    }
    return self;
}

- (void)createSubViews{
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont appFontThree];
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont appFontThree];
    _timeLabel.textColor = [UIColor grayFontColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(kWidthIphone7(200));
        make.height.equalTo(20);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kBorderMargin);
        make.top.equalTo(_titleLabel.top);
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(_titleLabel);
    }];
}

- (void)setRecordModel:(LHRecordModel *)recordModel{
    _recordModel = recordModel;
    _titleLabel.text = [NSString stringWithFormat:@"%@%@",recordModel.msg,recordModel.title];
    _timeLabel.text = [LHUtils timeStampSwitchMonthTimeStr:recordModel.time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
