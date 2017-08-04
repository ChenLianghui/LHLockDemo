//
//  LHLoginService.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLoginService.h"
#import "LHNetworkingManager.h"
#import "LHUserModel.h"

@interface LHLoginService ()

@property (nonatomic,strong)LHUserModel *userModel;

@end

@implementation LHLoginService

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

- (void)getVCodeWithMobileStr:(NSString *)mobileStr completed:(void (^)())completed failure:(void (^)())failure{
    if (mobileStr) {
        NSDictionary *params = @{@"mobile" : mobileStr};
        [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/account/getCode" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            if (completed) {
                completed();
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            if (failure) {
                failure();
            }
        }];
    }else{
        NSLog(@"mobile or role is nil");
    }
}


- (void)loginWithUserName:(NSString *)username andPassword:(NSString *)password completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":username,@"password":password};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/account/login" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"response:%@",responseObject);
        NSDictionary *dataDic = [responseObject valueForKey:@"data"];
//        [JPUSHService setTags:set alias:mobileStr callbackSelector:nil object:nil];
        [_userModel setValuesForKeysWithDictionary:dataDic];
        [[NSUserDefaults standardUserDefaults]setValue:username forKey:key_currentUserName];
        [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeLogin object:nil];
        if (completed) {
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

- (void)loginWithTokenCompleted:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    if (_userModel.token) {
        NSDictionary *params = @{@"username":_userModel.username,@"token":_userModel.token};
        [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/account/tokenLogin" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *dataDic = [responseObject valueForKey:@"data"];
            //        [JPUSHService setTags:set alias:mobileStr callbackSelector:nil object:nil];
            [_userModel setValuesForKeysWithDictionary:dataDic];
            if (completed) {
                completed(task,responseObject);
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            if (failure) {
                failure(operation,error);
            }
        }];
    }else{
        if (self.TokenLoginBlock) {
            self.TokenLoginBlock();
        }
    }
}

- (void)registerNewAcountWithUserName:(NSString *)username andPassword:(NSString *)password andMoblie:(NSString *)mobile andVcode:(NSString *)vcode completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary *params = @{@"username":username,@"password":password,@"mobile":mobile,@"veriCode":vcode};
    [[LHNetworkingManager sharedInstance] POSTDateWithUrlString:@"/v1/account/register" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        if (completed) {
            [[NSUserDefaults standardUserDefaults] setValue:username forKey:key_currentUserName];
            completed(task,responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

@end
