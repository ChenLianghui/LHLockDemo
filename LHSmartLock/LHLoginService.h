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

- (void)loginWithUserName:(NSString *)username andPassword:(NSString *)password completed:(void(^)())completed failure:(void (^)())failure;

- (void)loginWithTokenCompleted:(void(^)())completed failure:(void (^)())failure;

- (void)registerNewAcountWithUserName:(NSString *)username andPassword:(NSString *)password andMoblie:(NSString *)mobile andVcode:(NSString *)vcode completed:(void(^)())completed failure:(void (^)())failure;

@end
