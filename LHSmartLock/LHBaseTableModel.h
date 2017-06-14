//
//  LHBaseTableModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHBaseTableModel : LHBaseModel

@property (nonatomic,copy)NSString *iconName;
@property (nonatomic,copy)NSString *titleStr;
@property (nonatomic,copy)NSString *rightStr;
@property (nonatomic,assign)BOOL isHasSwitch;

+ (LHBaseTableModel *)initBaseModelWithIconName:(NSString *)iconName labelTitle:(NSString *)title rightTitle:(NSString *)rightStr isHasSwitch:(BOOL)isHasSwitch;

@end
