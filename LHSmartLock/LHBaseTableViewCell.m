//
//  LHBaseTableViewCell.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseTableViewCell.h"

@implementation LHBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
        self.contentView.backgroundColor = [UIColor backgroundColor];
    }
    return self;
}

- (void)creatSubViews{
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_nameLabel];
    
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:_arrowImageView];
    
    _ASwitch = [UISwitch new];
    [_ASwitch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_ASwitch];
    
    _rightLabel = [UILabel new];
    _rightLabel.font = [UIFont appFontTwo];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.centerY.equalTo(self.contentView.centerY);
        make.height.equalTo(kWidthIphone7(20));
        make.width.equalTo(_iconImageView.height);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.top);
        make.left.equalTo(self.iconImageView.right).offset(kWidthIphone7(8));
        make.right.equalTo(self.contentView.right).offset(-kBorderMargin-kWidthIphone7(55));
        make.bottom.equalTo(self.iconImageView.bottom);
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.centerY);
        make.right.equalTo(-kBorderMargin);
        make.width.equalTo(kWidthIphone7(10));
        make.height.equalTo(kHeightIphone7(16));
    }];
    
    [_ASwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.right);
        make.centerY.equalTo(self.contentView.centerY);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.top);
        make.right.offset(-kBorderMargin);
        make.width.equalTo(kWidthIphone7(100));
        make.bottom.equalTo(self.iconImageView.bottom);
    }];
}

- (void)switchClicked:(UISwitch *)Aswitch{
    if (self.switchBlock) {
        self.switchBlock(Aswitch.isOn);
    }
//    if (Aswitch.isOn) {
//        NSLog(@"on");
//    }else{
//        NSLog(@"off");
//    }
}

- (void)setModel:(LHBaseTableModel *)model{
    _model = model;
    [self.iconImageView setImage:[UIImage imageNamed:model.iconName]];
    self.nameLabel.text = model.titleStr;
    self.rightLabel.text = model.rightStr;
    if (model.isHasSwitch) {
        self.ASwitch.hidden = NO;
        self.arrowImageView.hidden = YES;
        self.rightLabel.hidden = YES;
    }else{
        self.ASwitch.hidden = YES;
        if (![LHUtils isEmptyStr:model.rightStr]) {
            self.arrowImageView.hidden = YES;
            self.rightLabel.hidden = NO;
        }else{
            self.arrowImageView.hidden = NO;
            self.rightLabel.hidden = YES;
        }
    }
}

- (void)setGatewayModel:(LHGatewayModel *)gatewayModel{
    _gatewayModel = gatewayModel;
    self.nameLabel.text = gatewayModel.gatewayName;
    self.iconImageView.image = [UIImage imageNamed:@"manage_gateway"];
    self.ASwitch.hidden = YES;
    self.arrowImageView.hidden = NO;
    self.rightLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
