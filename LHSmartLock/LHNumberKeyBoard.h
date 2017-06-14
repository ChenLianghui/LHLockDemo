//
//  LHNumberKeyBoard.h
//  customKeyBoard
//
//  Created by 陈良辉 on 2017/5/31.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LHNumberKeyBoardDelegate <NSObject>

@optional
- (void)numberButtonHadClickedWithString:(NSString *)string;
- (void)deleteButtonHadClicked;
- (void)commitButtonHadClicked;

@end

@interface LHNumberKeyBoard : UIView

@property (nonatomic,weak) id<LHNumberKeyBoardDelegate> delegate;

@end
