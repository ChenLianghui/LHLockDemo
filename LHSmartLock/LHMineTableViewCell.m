//
//  LHMineTableViewCell.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHMineTableViewCell.h"

@implementation LHMineTableViewCell

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
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_titleLabel];
    
    _rightLabel = [UILabel new];
    _rightLabel.font = [UIFont appFontThree];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_rightLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.width.equalTo(kWidthIphone7(100));
        make.top.equalTo(kHeightIphone7(10));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kBorderMargin);
        make.top.equalTo(_titleLabel.top);
        make.width.equalTo(kWidthIphone7(150));
        make.height.equalTo(_titleLabel.height);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
