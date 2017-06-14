//
//  LHMessageTableViewCell.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHMessageModel.h"

@interface LHMessageTableViewCell : UITableViewCell

@property (nonatomic,strong)LHMessageModel *model;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *desTitleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIView *iconView;

@end
