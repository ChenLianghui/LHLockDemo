//
//  LHNetWorkDefines.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/19.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#ifndef LHNetWorkDefines_h
#define LHNetWorkDefines_h

typedef enum : NSUInteger {
    LHApiErrorCode_OK = 0,
    LHApiErrorCode_NoLogin = 2000,//用户未登录
    LHApiErrorCode_UserNameUsed = 2002,//用户名被占用
    LHApiErrorCode_UserNameLoginError = 2007,//用户名或密码错误
    LHApiErrorCode_TokenNotNULL = 2008,//token不能为空
    LHApiErrorCode_TokenOverTime = 2009,//token过期
    LHApiErrorCode_VcodeGetError = 2010,//验证码获取失败
    LHApiErrorCode_VCodeError = 2011,//验证码错误
    LHApiErrorCode_VCodeValid = 2012,//验证码无效
    LHApiErrorCode_NotRegister = 2013,//用户未注册
    
    //锁
    LHApiErrorCode_LockNotBind = 3002,//锁未绑定
    LHApiErrorCode_LockAlreadyBind = 3003,//锁已绑定
    LHApiErrorCode_LockPasswordError = 3004,//锁密码错误
    LHApiErrorCode_LockUserAlreadyAuth = 3005,//对用户重复授权
    LHApiErrorCode_LockUserNotAuth = 3006,//对该用户未授权
    
    //网关
    LHApiErrorCode_GatewayNotBind = 4002,//网关未绑定
    LHApiErrorCode_GatewayAlreadyBind = 4003,//网关已经绑定
    
    //设备通信错误
    LHApiErrorCode_JsonError = 5000,//JSON格式错误
    LHApiErrorCode_KeyNotExsit = 5001,//缺少关键字
    
    LHApiErrorCode_NotDefine = 10000,//错误未定义
    LHApiErrorCode_SystemException = 10001//系统异常
} LHApiErrorCode;

#endif /* LHNetWorkDefines_h */
