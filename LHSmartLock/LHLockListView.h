//
//  LHLockListView.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/9.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHLockListViewDelegate <NSObject>

- (void)ListViewDidTapItemWithIndex:(NSInteger)index;

@end

@interface LHLockListView : UIView

@property (nonatomic,strong)NSMutableArray *lockArray;//数据源
@property (nonatomic,strong)UIColor *lineColor;//指示条的颜色，默认为绿色
@property (nonatomic,assign)CGFloat lineHeight;//指示条高度，默认为2；
@property (nonatomic,assign)CGFloat lineWidth;//指示条宽度，默认跟item同宽
@property (nonatomic,weak) id<LHLockListViewDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;

@end
