//
//  BKLoadingView.h
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/17.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "MBProgressHUD.h"

@protocol BKLoadingViewDelegate <NSObject>

- (void)didLoadingViewHide;

@end

@interface BKLoadingView : UIView

@property(nonatomic, strong)     MBProgressHUD       *HUD;
@property(nonatomic, weak) id<BKLoadingViewDelegate> delegate;

#pragma mark -
#pragma mark label function

- (void)showWithLabel:(NSString *)aLabel duration:(NSTimeInterval)duration;
- (void)showWithLabel:(NSString *)aLabel detailsLabel:(NSString *)aDetailsLabel duration:(NSTimeInterval)duration;

#pragma mark -
#pragma mark text only function

- (void)showTextOnlyWithMessage:(NSString *)aMessage duration:(NSTimeInterval)duration;

#pragma mark -
#pragma mark custom view function

- (void)showWithCustomView:(UIView *)aCustomView label:(NSString *)aLabel duration:(NSTimeInterval)duration;
- (void)showWithCustomView:(UIView *)aCustomView label:(NSString *)aLabel duration:(NSTimeInterval)duration complete:(MBProgressHUDCompletionBlock)block;

#pragma mark -
#pragma mark hide function

- (void)hide:(BOOL)animated;

@end
