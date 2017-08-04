//
//  LHLockModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHLockModel : LHBaseModel

@property (nonatomic,copy) NSString *lockName;
@property (nonatomic,copy) NSString *lockSn;
@property (nonatomic,assign) BOOL online;//是否在线
@property (nonatomic,copy) NSString *status;//open/close/unknow
@property (nonatomic,copy) NSString *power;//low/middle/high/unknow
@property (nonatomic,copy) NSString *alarm;//open/close

@end
