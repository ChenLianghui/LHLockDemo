//
//  LHSelectGatewayCollectionViewCell.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/7.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHGatewayModel.h"


@interface LHSelectGatewayCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)LHGatewayModel *model;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end
