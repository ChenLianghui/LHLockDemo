//
//  UIViewController+HUD.h
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/17.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKLoadingView.h"

// loading默认超时时间 单位秒s
#define kHUDLoadingOvertime         60
// tip提示默认显示时长 单位秒s
#define kHUDNormalDuration          1

@interface UIViewController (HUD) <BKLoadingViewDelegate>

#pragma mark -
#pragma mark loading view

- (void)showWaitLoading;
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showLoadingWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showLoadingWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration;
- (void)hideLoading;

#pragma mark -
#pragma mark message view

- (void)showMessage:(NSString *)message;
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;

#pragma mark -
#pragma mark result view

- (void)showSucceed:(NSString *)message complete:(MBProgressHUDCompletionBlock)block;
- (void)showFailed:(NSString *)message;
@end
