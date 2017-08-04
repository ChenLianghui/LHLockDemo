//
//  LHRecordModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHRecordModel : LHBaseModel

@property (nonatomic,copy)NSString *time;//时间戳
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *msg;
@property (nonatomic,copy)NSString *type;

@end
