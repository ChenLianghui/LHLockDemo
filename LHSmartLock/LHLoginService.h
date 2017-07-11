//
//  LHLoginService.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^tokenLoginBlock)(void);

@interface LHLoginService : NSObject

@property (nonatomic,copy)tokenLoginBlock TokenLoginBlock;

+ (instancetype)sharedInstance;

- (void)getVCodeWithMobileStr:(NSString *)mobileStr completed:(void(^)())completed failure:(void (^)())failure;

- (void)loginWithUserName:(NSString *)username andPassword:(NSString *)password completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)loginWithTokenCompleted:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)registerNewAcountWithUserName:(NSString *)username andPassword:(NSString *)password andMoblie:(NSString *)mobile andVcode:(NSString *)vcode completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//- (void)forgetPasswordWithUserName:(NSString *)userName 

@end
