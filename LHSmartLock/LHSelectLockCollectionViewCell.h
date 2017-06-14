//
//  LHSelectLockCollectionViewCell.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHLockModel.h"

@interface LHSelectLockCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *batteryImageView;
@property (nonatomic,strong)LHLockModel *model;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,assign)BOOL isEmpty;

@end
