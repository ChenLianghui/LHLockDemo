//
//  LHBaseTableModel.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseTableModel.h"

@implementation LHBaseTableModel

+ (LHBaseTableModel *)initBaseModelWithIconName:(NSString *)iconName labelTitle:(NSString *)title rightTitle:(NSString *)rightStr isHasSwitch:(BOOL)isHasSwitch{
    LHBaseTableModel *model = [[LHBaseTableModel alloc] init];
    model.iconName = iconName;
    model.titleStr = title;
    model.rightStr = rightStr;
    model.isHasSwitch = isHasSwitch;
    return model;
}

@end
