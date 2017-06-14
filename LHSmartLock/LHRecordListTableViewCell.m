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
    _roomLabel = [UILabel new];
    _roomLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_roomLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont appFontTwo];
    _timeLabel.textColor = [UIColor grayFontColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    
    [_roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(120));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kBorderMargin);
        make.top.equalTo(_roomLabel.top);
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
    }];
}

- (void)setRecordModel:(LHRecordCellModel *)recordModel{
    _recordModel = recordModel;
    _roomLabel.text = recordModel.titleStr;
    _timeLabel.text = recordModel.timeStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
