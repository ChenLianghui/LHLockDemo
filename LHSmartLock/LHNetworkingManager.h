//
//  LHNetworkingManager.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginBlock)(void);
@class AFHTTPSessionManager;
@interface LHNetworkingManager : NSObject

@property (nonatomic,copy)LoginBlock loginBlock;
@property (nonatomic,strong)AFHTTPSessionManager *manager;

+ (instancetype)sharedInstance;

- (void) GETDateWithUrlString:(NSString *)URLString success:(void (^)(NSURLSessionTask *task, id responseObject))success failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)POSTDateWithUrlString:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionTask *task, id responseObject))success failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

@end
