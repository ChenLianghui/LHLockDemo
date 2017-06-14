//
//  LHLockModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHLockModel : LHBaseModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int electricNumber;
@property (nonatomic,assign) BOOL isLock;

@end
