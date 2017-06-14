//
//  LHMessageModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHMessageModel : LHBaseModel

@property (nonatomic,copy)NSString *titleStr;
@property (nonatomic,copy)NSString *detailStr;
@property (nonatomic,copy)NSString *timeStr;
@property (nonatomic,assign)BOOL isWarning;

@end
