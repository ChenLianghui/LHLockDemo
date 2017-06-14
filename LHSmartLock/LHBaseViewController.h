//
//  LHBaseViewController.h
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBlock)();

@interface LHBaseViewController : UIViewController

- (void)addTitleViewWithName:(NSString *)name;
- (void)addTitleViewWithName:(NSString *)name textColor:(UIColor *)color;
- (void)addItemWithName:(NSString *)name isLeft:(BOOL)isleft WithBlock:(myBlock)block;
- (void)addImageWithName:(NSString *)name isLeft:(BOOL)isleft WithBlock:(myBlock)block;

@end
