//
//  LHBaseTableViewCell.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHBaseTableModel.h"

//typedef enum : NSUInteger {
//    LHBaseTableViewCellStyleNomal=0,//有icon,title,右箭头
//    LHBaseTableViewCellStyleRightLabel,//有icon,title,右label
//    LHBaseTableViewCellStyleRightSwitch,//有icon，title，右switch
//    LHBaseTableViewCellStyleNoIcon,//有title，右箭头
//} LHBaseTableViewCellStyle;

@interface LHBaseTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *arrowImageView;
@property (nonatomic,strong)UISwitch *ASwitch;
@property (nonatomic,strong)LHBaseTableModel *model;
//@property (nonatomic,assign)LHBaseTableViewCellStyle style;
@property (nonatomic,strong)UILabel *rightLabel;

@end
