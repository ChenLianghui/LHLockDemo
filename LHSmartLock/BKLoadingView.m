//
//  BKLoadingView.m
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/17.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "BKLoadingView.h"

@interface BKLoadingView () <MBProgressHUDDelegate>
{
}

@end

@implementation BKLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        _HUD.minSize = CGSizeZero;
        _HUD.minShowTime = 0.5;
        _HUD.label.font = [UIFont appFontOne];
        //_HUD.labelFont = [UIFont appFontOne];
        [self addSubview:_HUD];
    }
    return self;
}

#pragma mark -
#pragma mark label function

- (void)showWithLabel:(NSString *)aLabel duration:(NSTimeInterval)duration {
    [self showWithLabel:aLabel detailsLabel:nil duration:duration];
}

- (void)showWithLabel:(NSString *)aLabel detailsLabel:(NSString *)aDetailsLabel duration:(NSTimeInterval)duration {
    _HUD.delegate = self;
    _HUD.label.text = aLabel;
    //_HUD.labelText = aLabel;
    _HUD.detailsLabel.text = aDetailsLabel;
    //_HUD.detailsLabelText = aDetailsLabel;
    [_HUD showAnimated:YES];
    //[_HUD show:YES];
    [_HUD hideAnimated:YES afterDelay:duration];
}

#pragma mark -
#pragma mark text only function
- (void)showTextOnlyWithMessage:(NSString *)aMessage duration:(NSTimeInterval)duration {
    _HUD.mode = MBProgressHUDModeText;
    _HUD.removeFromSuperViewOnHide = YES;
    [self showWithLabel:aMessage duration:duration];
}

#pragma mark -
#pragma mark custom view function
- (void)showWithCustomView:(UIView *)aCustomView label:(NSString *)aLabel duration:(NSTimeInterval)duration {
    [self showWithCustomView:aCustomView label:aLabel duration:duration complete:nil];
}

- (void)showWithCustomView:(UIView *)aCustomView label:(NSString *)aLabel duration:(NSTimeInterval)duration complete:(MBProgressHUDCompletionBlock)block {
    // Set custom view mode
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.customView = aCustomView;
    _HUD.delegate = self;
    _HUD.label.text = aLabel;
    _HUD.completionBlock = block;
    [_HUD showAnimated:YES];
    [_HUD hideAnimated:YES afterDelay:duration];
}

#pragma mark -
#pragma mark hide function

- (void)hide:(BOOL)animated {
    [_HUD hideAnimated:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doneLoadingTask) object:nil];
    _HUD.minSize = CGSizeZero;
}

- (void)doneLoadingTask {
    [self hide:NO];
}

#pragma mark MBProgressHUDDelegate method

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (_delegate && [_delegate respondsToSelector:@selector(didLoadingViewHide)]) {
        [_delegate didLoadingViewHide];
    }
}

/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */

@end
