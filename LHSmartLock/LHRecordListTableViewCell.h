//
//  LHRecordListTableViewCell.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHRecordModel.h"

@interface LHRecordListTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)LHRecordModel *recordModel;

@end
