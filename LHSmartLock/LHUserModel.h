//
//  LHUserModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHUserModel : LHBaseModel

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy) NSString * mobile;
@property (nonatomic,copy) NSString * _id;
@property (nonatomic,copy) NSString * token;

+ (instancetype)sharedInstance;

- (BOOL)isLogin;

- (void)logout;

@end
