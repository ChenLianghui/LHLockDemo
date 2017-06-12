//
//  UIBarButtonItem+Badge.m
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/8/10.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "UIBarButtonItem+Badge.h"

@interface BadgeView : UIView

@property(nonatomic, strong) UILabel *badgeLabel;

@end

@implementation BadgeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];

        _badgeLabel = [UILabel new];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.font = [UIFont appFontFour];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_badgeLabel];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    CGFloat paddingSize = kWidthIphone7(2);

    CGSize size = [_badgeLabel sizeThatFits:CGSizeMake(kScreenWidth, kScreenHeight)];
    if (size.height == 0) {
        paddingSize = kWidthIphone7(4);
    }
    self.layer.cornerRadius = size.height/2 + paddingSize;

    [self.badgeLabel updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.greaterThanOrEqualTo(size.height);
        make.height.equalTo(size.height);
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(paddingSize, paddingSize, paddingSize, paddingSize));
    }];
}

@end

@interface UIBarButtonItem ()

@property(nonatomic, strong) BadgeView *badgeView;

@end

@implementation UIBarButtonItem (Badge)

- (UILabel *)badgeView {
    return objc_getAssociatedObject(self, @selector(badgeView));
}

- (void)setBadgeView:(NSString *)badgeView {
    objc_setAssociatedObject(self, @selector(badgeView), badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)badge {
    return self.badgeView.badgeLabel.text;
}

- (void)setBadge:(NSString *)badge {
    if (!self.badgeView) {
        [self initBadgeView];
        self.customView.clipsToBounds = NO;
    }
    if (badge) {
        self.badgeView.hidden = NO;
        self.badgeView.badgeLabel.text = badge;
        [self.badgeView updateConstraints];
    } else {
        self.badgeView.hidden = YES;
    }
}

- (void)initBadgeView {
    self.badgeView = [BadgeView new];
    [self.customView addSubview:self.badgeView];

    [self.badgeView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.customView.right).offset(kSizeFrom750(5));
        make.centerY.equalTo(self.customView.top);
    }];
}

@end
