//
//  LHHomeHeaderView.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHHomeHeaderViewDelegate <NSObject>

@optional

- (void)hadChangeGatewayWithIndex:(NSInteger)index;
- (void)hadClickedTheEmptyGateway;

@end

@interface LHHomeHeaderView : UIView

@property (nonatomic,copy)NSArray *gatewayArray;

@property (nonatomic,weak)id<LHHomeHeaderViewDelegate> delegate;


@end
