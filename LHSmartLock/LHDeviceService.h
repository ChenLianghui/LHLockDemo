//
//  LHDeviceService.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/19.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHDeviceService : NSObject

+ (instancetype)sharedInstance;

- (void)bindGateWayWithSN:(NSString *)SNStr andGateWayName:(NSString *)name completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)deleteGateWayWithSN:(NSString *)SNStr completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)reNameGateWayWithName:(NSString *)name andSN:(NSString *)SNStr completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)replaceTheOldGateWayWithTheOldSN:(NSString *)SNStr andTheNewSN:(NSString *)NewSN andTheNewGateWayName:(NSString *)newName completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)findAllGatewayCompleted:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;


- (void)bindLockWithGateWaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andLockName:(NSString *)lockName andPassword:(NSString *)password completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)unbindLockWithLockSn:(NSString *)lock_sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)findAllLockUnderTheGatewaySN:(NSString *)sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)controlTheLockWithGatewaySN:(NSString *)gatewaySn lockSn:(NSString *)lockSn ToStatus:(NSString *)status completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)changeLockNameWithGatewaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andLockName:(NSString *)lockName completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)changeLockPasswordWithGatewaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)lockAlarmSettingWithGatewaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn andAlarm:(NSString *)alarm completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)getLockTemporaryPasswordWithGateWaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)updateLockTemporaryPasswordWithGateWaySN:(NSString *)gateway_sn andLockSN:(NSString *)lock_sn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)addNewAuthWithLockSN:(NSString *)lock_sn andAuth_user:(NSString *)auth_user andPassword:(NSString *)password andStartTime:(NSString *)startStr andEndTime:(NSString *)endStr status:(NSString *)status completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)updateAuthWithLockSN:(NSString *)lock_sn andAuth_user:(NSString *)auth_user andPassword:(NSString *)password andStartTime:(NSDate *)startDate andEndTime:(NSDate *)endDate completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)deleteAuthWithLockSN:(NSString *)lock_sn andAuth_user:(NSString *)auth_user completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)findAllAuthUserUnderTheLockWithLockSN:(NSString *)lockSn completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)getNewsWithIsPush:(BOOL)isPush location:(int)currentLocation completed:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

- (void)getAllLockListCompleted:(void (^)(NSURLSessionTask *task, id responseObject))completed failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

@end
