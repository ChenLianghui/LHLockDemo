//
//  LHNetworkingManager.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHNetworkingManager.h"
#import "LHUserModel.h"
#import "JXTAlertManagerHeader.h"

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
//    NSDictionary *enParameters = [NSDictionary dictionaryWithObjectsAndKeys:dicJson,@"params", nil];
    [self.manager POST:[LHBaseUrl stringByAppendingString:URLString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
//        [responseObject setValue:dataDic forKey:@"data"];
        NSNumber *codeNum = [dict objectForKey:@"code"];
        NSInteger code = [codeNum integerValue];
        NSString *errorStr;
        switch (code) {
            case LHApiErrorCode_OK:
                success(task,dict);
                break;
            case LHApiErrorCode_TokenOverTime:
                errorStr = NSLocalizedString(@"登录信息已失效，请重新登录", nil);
                if (self.loginBlock) {
                    self.loginBlock();
                }else{
                    NSLog(@"loginBlock is nil");
                }
                break;
            case LHApiErrorCode_NoLogin:
                errorStr = NSLocalizedString(@"用户未登录", nil);
                if (self.loginBlock) {
                    self.loginBlock();
                }else{
                    NSLog(@"loginBlock is nil");
                }
                break;
            case LHApiErrorCode_VCodeError:
                errorStr = NSLocalizedString(@"验证码错误", nil);
                break;
            case LHApiErrorCode_VCodeValid:
                errorStr = NSLocalizedString(@"验证码无效", nil);
                break;
            case LHApiErrorCode_KeyNotExsit:
                errorStr = NSLocalizedString(@"缺少关键字", nil);
                break;
            case LHApiErrorCode_LockNotBind:
                errorStr = NSLocalizedString(@"锁未绑定", nil);
                break;
            case LHApiErrorCode_LockAlreadyBind:
                errorStr = NSLocalizedString(@"锁已绑定", nil);
                break;
            case LHApiErrorCode_NotRegister:
                errorStr = NSLocalizedString(@"用户未注册", nil);
                break;
            case LHApiErrorCode_UserNameUsed:
                errorStr = NSLocalizedString(@"用户名被占用", nil);
                break;
            case LHApiErrorCode_VcodeGetError:
                errorStr = NSLocalizedString(@"验证码获取失败", nil);
                break;
            case LHApiErrorCode_GatewayNotBind:
                errorStr = NSLocalizedString(@"网关未绑定", nil);
                break;
            case LHApiErrorCode_LockUserNotAuth:
                errorStr = NSLocalizedString(@"对该用户未授权", nil);
                break;
            case LHApiErrorCode_LockPasswordError:
                errorStr = NSLocalizedString(@"锁密码错误", nil);
                break;
            case LHApiErrorCode_GatewayAlreadyBind:
                errorStr = NSLocalizedString(@"网关已经绑定", nil);
                break;
            case LHApiErrorCode_UserNameLoginError:
                errorStr = NSLocalizedString(@"用户名或密码错误", nil);
                break;
            case LHApiErrorCode_LockUserAlreadyAuth:
                errorStr = NSLocalizedString(@"对用户重复授权", nil);
                break;
            default:
                errorStr = NSLocalizedString(@"出现未知错误", nil);
                break;
        }
        if (![LHUtils isEmptyStr:errorStr]) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = errorStr;
            [hud showAnimated:YES];
            [hud hideAnimated:YES afterDelay:1];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = NSLocalizedString(@"网络出现错误", nil);
//        [hud showAnimated:YES];
//        [hud hideAnimated:YES afterDelay:1];
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
