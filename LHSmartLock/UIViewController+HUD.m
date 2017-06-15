//
//  UIViewController+HUD.m
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/17.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "UIViewController+HUD.h"

#define LoadingMinTime 0.2f

@interface UIViewController ()
@property(nonatomic, strong) BKLoadingView *loadingView;
@end

@implementation UIViewController (HUD)

- (void)setLoadingView:(BKLoadingView *)loadingView {
    objc_setAssociatedObject(self, @selector(loadingView), loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)loadingView {
    return objc_getAssociatedObject(self, @selector(loadingView));
}

#pragma mark -
#pragma mark loading view

static NSDate *createTime = nil;

- (void)checkCreateLoading {
    createTime = [NSDate date];
    if (!self.loadingView) {
        self.loadingView = [BKLoadingView new];
        self.loadingView.backgroundColor = [UIColor colorWithHex:0x333333 alpha:0.5];
        [self.view addSubview:self.loadingView];
        [self.view bringSubviewToFront:self.loadingView];
        self.loadingView.delegate = self;
        [self.loadingView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    self.loadingView.userInteractionEnabled = YES;
}

- (void)showWaitLoading {
    [self showLoadingWithMessage:@"请稍候..."];
}

- (void)showLoadingWithMessage:(NSString *)message {
    [self showLoadingWithMessage:message duration:kHUDLoadingOvertime];
}

- (void)showLoadingWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [self checkCreateLoading];
    [self.loadingView showWithLabel:message duration:duration];
}

- (void)showLoadingWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration {
    [self checkCreateLoading];
    [self.loadingView showWithLabel:title detailsLabel:message duration:duration];
}

- (void)hideLoading {
    [self.loadingView hide:NO];
}

#pragma mark -
#pragma mark message view

- (void)showMessage:(NSString *)message {
    [self showMessage:message duration:kHUDNormalDuration];
}

- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [self checkCreateLoading];
    self.loadingView.userInteractionEnabled = NO;
    [self.loadingView showTextOnlyWithMessage:message duration:duration];
}

#pragma mark -
#pragma mark result view

- (void)showSucceed:(NSString *)message complete:(MBProgressHUDCompletionBlock)block {
    [self checkCreateLoading];
    UIImage     *tipImage = [UIImage imageNamed:@"tip_success"];
    UIImageView *tipImageView = [[UIImageView alloc] initWithImage:tipImage];
    self.loadingView.HUD.minSize = CGSizeMake(kSizeFrom750(460), kSizeFrom750(250));
    [self.loadingView showWithCustomView:tipImageView label:message duration:kHUDNormalDuration complete:block];
}

- (void)showFailed:(NSString *)message {
    [self checkCreateLoading];
    UIImage     *tipImage = [UIImage imageNamed:@"tip_error"];
    UIImageView *tipImageView = [[UIImageView alloc] initWithImage:tipImage];
    self.loadingView.HUD.minSize = CGSizeMake(kSizeFrom750(460), kSizeFrom750(250));
    [self.loadingView showWithCustomView:tipImageView label:message duration:kHUDNormalDuration];
}

#pragma mark KDLoadingViewDelegate method

- (void)didLoadingViewHide {
    if (self.loadingView) {
        [UIView animateWithDuration:0.2 animations:^{
            self.loadingView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.loadingView removeFromSuperview];
            self.loadingView.delegate = nil;
            self.loadingView = nil;
        }];
    }
}

@end
