//
//  LHDeviceService.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/19.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHDeviceService.h"
#import "LHNetworkingManager.h"
#import "LHUserModel.h"

@interface LHDeviceService ()

@property (nonatomic,strong)LHUserModel *userModel;

@end

@implementation LHDeviceService

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if (self == [super init]) {
        _userModel = [LHUserModel sharedInstance];
    }
    return self;
}



/**
 绑定网关

 @param SNStr 网关序列号
 @param name 网关名称

 */
- (void)bindGateWayWithSN:(NSString *)SNStr andGateWayName:(NSString *)name completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":SNStr,@"gatewayName":name};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/gateway/bind" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 删除网关

 @param SNStr 网关序列号

 */
- (void)deleteGateWayWithSN:(NSString *)SNStr completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":SNStr};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/gateway/unbind" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 网关重命名

 @param name 网关名称
 @param SNStr 网关序列号

 */
- (void)reNameGateWayWithName:(NSString *)name andSN:(NSString *)SNStr completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":SNStr,@"gatewayName":name};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/gateway/rename" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 网关替换

 @param SNStr 当前网关序列号
 @param NewSN 新的网关序列号
 @param newName 新的网关名称

 */
- (void)replaceTheOldGateWayWithTheOldSN:(NSString *)SNStr andTheNewSN:(NSString *)NewSN andTheNewGateWayName:(NSString *)newName completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"oldGatewaySn":SNStr,@"gatewaySn":NewSN,@"gatewayName":newName};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/gateway/replace" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 查询所有网关

 */
- (void)findAllGatewayCompleted:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/gateway/findAll" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 绑定锁

 @param gateway_sn 网关序列号
 @param lock_sn 锁序列号
 @param lockName 锁名称
 @param password 密码

 */
- (void)bindLockWithGateWaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andLockName:(NSString *)lockName andPassword:(NSString *)password completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":gateway_sn,@"lockSn":lock_sn,@"lockName":lockName,@"password":password};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/bind" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 删除锁/解绑锁

 @param lock_sn 锁序列号

 */
- (void)unbindLockWithLockSn:(NSString *)lock_sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"lockSn":lock_sn};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/unbind" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 查询特定网关下锁的状态

 @param sn 网关SN

 */
- (void)findAllLockUnderTheGatewaySN:(NSString *)sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":sn};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/get/list" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 开关锁操作

 @param gatewaySn 网关序列号
 @param lockSn 锁序列号
 @param status 要变成的状态（open为开锁，close为关锁）

 */
- (void)controlTheLockWithGatewaySN:(NSString *)gatewaySn lockSn:(NSString *)lockSn ToStatus:(NSString *)status completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":gatewaySn,@"lockSn":lockSn,@"status":status};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/control" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 锁重命名

 @param gateway_sn 网关序列号
 @param lock_sn 锁序列号
 @param lockName 锁名称

 */
- (void)changeLockNameWithGatewaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andLockName:(NSString *)lockName completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":gateway_sn,@"lockSn":lock_sn,@"lockName":lockName};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/rename" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 修改锁密码

 @param gateway_sn 网关序列号
 @param lock_sn 锁序列号
 @param oldPassword 旧密码
 @param newPassword 新密码

 */
- (void)changeLockPasswordWithGatewaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":gateway_sn,@"lockSn":lock_sn,@"password":oldPassword,@"newPassword":newPassword};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/set/password" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 设置是否允许锁告警

 @param gateway_sn 网关序列号
 @param lock_sn 锁序列号
 @param alarm open为允许，close为禁止

 */
- (void)lockAlarmSettingWithGatewaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andAlarm:(NSString *)alarm completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"lockSn":lock_sn,@"alarm":alarm};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/set/alarm" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 获取锁的临时密码

 */
- (void)getLockTemporaryPasswordWithGateWaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    if (![LHUtils isEmptyStr:lock_sn]) {
        NSDictionary *params = @{@"username":_userModel.username,@"lockSn":lock_sn};
        [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/tpassword/get" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            if (completed) {
                completed(task,responseObject);
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            if (failure) {
                failure(operation,error);
            }
        }];
    }else{
        
    }
}


/**
 更新临时密码

 */
- (void)updateLockTemporaryPasswordWithGateWaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"gatewaySn":gateway_sn,@"lockSn":lock_sn};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/tpassword/update" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 新增授权用户

 @param lock_sn 锁序列号
 @param auth_user 授权用户名
 @param password 授权用户开锁密码
 @param startStr 开始时间
 @param endStr 结束时间
 */
- (void)addNewAuthWithLockSN:(NSString *)lock_sn andAuth_user:(NSString *)auth_user andPassword:(NSString *)password andStartTime:(NSString *)startStr andEndTime:(NSString *)endStr status:(NSString *)status completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"authUser":auth_user,@"lockSn":lock_sn,@"password":password,@"start":[LHUtils timeSwitchTimestamp:startStr],@"end":[LHUtils timeSwitchTimestamp:endStr],@"status":status};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/auth/add" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 更新授权用户信息

 @param lock_sn 锁序列号
 @param auth_user 授权用户名
 @param password 授权用户开锁密码
 @param startStr 开始时间
 @param endStr 结束时间

 */
- (void)updateAuthWithLockSN:(NSString *)lock_sn andAuth_user:(NSString *)auth_user andPassword:(NSString *)password andStartTime:(NSString *)startStr andEndTime:(NSString *)endStr completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"authUser":auth_user,@"lockSn":lock_sn,@"password":password,@"start":startStr,@"end":endStr};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/auth/update" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

/**
 删除授权用户

 @param lock_sn 锁序列号
 @param auth_user 授权用户名

 */
- (void)deleteAuthWithLockSN:(NSString *)lock_sn andAuth_user:(NSString *)auth_user completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"authUser":auth_user,@"lockSn":lock_sn};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/auth/delete" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 查询授权用户信息

 @param lockSn 锁序列号

 */
- (void)findAllAuthUserUnderTheLockWithLockSN:(NSString *)lockSn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username,@"lockSn":lockSn};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/lock/auth/list" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

/**
 查询操作日志或查询推送消息

 @param isPush yes为推送消息，no为操作日志
 @param currentLocation 当前获取的位置

 */
- (void)getNewsWithIsPush:(BOOL)isPush location:(int)currentLocation completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSString *type;
    if (isPush) {
        type = @"alarm";
    }else{
        type = @"operation";
    }
    
    NSDictionary *params = @{@"username":_userModel.username,@"type":type,@"start":[NSNumber numberWithInt:currentLocation],@"num":[NSNumber numberWithInt:10]};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/account/log/get" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


/**
 获取所有的锁列表

 */
- (void)getAllLockListCompleted:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":_userModel.username};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/account/get/locks" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

@end
