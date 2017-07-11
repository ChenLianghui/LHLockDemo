//
//  LHGatewayModel.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHGatewayModel : LHBaseModel

@property (nonatomic,copy)NSString *gatewayName;
@property (nonatomic,copy)NSString *gatewaySn;
@property (nonatomic,copy)NSArray *locks;
@property (nonatomic,assign)BOOL Online;//是否在线

@end
