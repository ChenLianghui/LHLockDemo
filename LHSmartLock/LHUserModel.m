//
//  LHUserModel.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHUserModel.h"

@implementation LHUserModel

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static id sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)setName:(NSString *)name{
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:key_userName];
}

- (NSString *)name{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key_userName];
}

- (void)set_id:(NSString *)_id{
    [[NSUserDefaults standardUserDefaults] setValue:_id forKey:key_userId];
}

- (NSString *)_id{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key_userId];
}

- (void)setMobile:(NSString *)mobile{
    [[NSUserDefaults standardUserDefaults] setValue:mobile forKey:key_userPhone];
}

- (NSString *)mobile{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key_userPhone];
}

- (void)setToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults]setValue:token forKey:key_userToken];
}

- (NSString *)token{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key_userToken];
}

- (BOOL)isLogin{
    if (self.token) {
        return YES;
    }
    return NO;
}

- (void)logout{
    self.token = nil;
}

@end
