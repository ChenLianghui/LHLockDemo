//
//  LHNetworkingManager.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHNetworkingManager.h"
#import "LHUserModel.h"


const NSString *LHBaseUrl = @"http://lockplat.com:9000";

@interface LHNetworkingManager ()

@property (nonatomic,strong)LHUserModel *userModel;

@end

@implementation LHNetworkingManager

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _userModel = [LHUserModel sharedInstance];
        _manager.operationQueue.maxConcurrentOperationCount = 3;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 10;
    }
    return self;
}

- (void) GETDateWithUrlString:(NSString *)URLString success:(void (^)(NSURLSessionTask *task, id responseObject))success failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    [self.manager GET:[LHBaseUrl stringByAppendingString:URLString] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (void)POSTDateWithUrlString:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionTask *task, id responseObject))success failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSString *dicJson = [self dictionaryToJson:parameters];
    NSDictionary *enParameters = [NSDictionary dictionaryWithObjectsAndKeys:dicJson,@"params", nil];
    [self.manager POST:[LHBaseUrl stringByAppendingString:URLString] parameters:enParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *deResponseObject = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        NSString *enJsonStr = [responseObject objectForKey:@"data"];
        NSData *jsonData = [enJsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        [deResponseObject setValue:dataDic forKey:@"data"];
        NSNumber *codeNum = [deResponseObject objectForKey:@"code"];
        NSInteger code = [codeNum integerValue];
        if (code == 0) {
            success(task,dataDic);
        }else{
            NSLog(@"deResponseObject:%@",deResponseObject);
            NSLog(@"%@ code: %@ failure message: %@",URLString,[deResponseObject objectForKey:@"code"],[deResponseObject objectForKey:@"message"]);
            if (code == 102) {
                //token过期
                if (self.loginBlock) {
                    self.loginBlock();
                }else{
                    NSLog(@"loginBlock is nil");
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        
    }];
}

//字典转json数据
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    if (dic) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return string;
    }else{
        return @"";
    }
}

@end
