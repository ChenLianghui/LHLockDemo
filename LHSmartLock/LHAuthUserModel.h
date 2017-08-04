//
//  LHAuthUserModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/7/25.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHAuthUserModel : LHBaseModel

@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *status;//valid,有效；invalid，无效；
@property (nonatomic,copy)NSString *start;//存的是时间戳
@property (nonatomic,copy)NSString *end;//存的是时间戳

@end
