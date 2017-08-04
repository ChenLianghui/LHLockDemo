//
//  LHAddUserViewController.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHLockModel.h"
#import "LHAuthUserModel.h"

@interface LHAddUserViewController : LHBaseViewController

@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,strong)LHLockModel *lockModel;
@property (nonatomic,strong)LHAuthUserModel *authUserModel;

@end
