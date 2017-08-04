//
//  LHHomeHeaderView.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/8.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHHomeHeaderView.h"
#import "LHSelectGatewayCollectionViewCell.h"
#define kGatewayCellId @"gatewayCellId"

@interface LHHomeHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation LHHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(kScreenSize.width, kHeightIphone7(200));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(200)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[LHSelectGatewayCollectionViewCell class] forCellWithReuseIdentifier:kGatewayCellId];

    [self addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.gatewayArray.count == 0) {
        return 1;
    }
    return self.gatewayArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHSelectGatewayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGatewayCellId forIndexPath:indexPath];
    if (self.gatewayArray.count == 0 || indexPath.row == self.gatewayArray.count) {
        cell.iconImageView.image = [UIImage imageNamed:@"gateway_close"];
        cell.titleLabel.text = NSLocalizedString(@"添加网关", nil);
        cell.titleLabel.textColor = [UIColor grayFontColor];
    }else{
        cell.model = self.gatewayArray[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.gatewayArray.count == 0 || indexPath.row == self.gatewayArray.count) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(hadClickedTheEmptyGateway)]) {
            [self.delegate hadClickedTheEmptyGateway];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.gatewayArray.count > 0 ) {
        NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
        if (_pageControl.currentPage != index) {
            [_pageControl setCurrentPage:index];
            if (self.delegate && [self.delegate respondsToSelector:@selector(hadChangeGatewayWithIndex:)]) {
                [self.delegate hadChangeGatewayWithIndex:index];
            }
        }
    }
}

- (void)setGatewayArray:(NSArray *)gatewayArray{
    _gatewayArray = gatewayArray;
    [self.collectionView reloadData];
    [_pageControl removeFromSuperview];
    _pageControl = nil;
    if (self.gatewayArray.count >= 1) {
        [self insertSubview:self.pageControl aboveSubview:_collectionView];
    }
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, self.bounds.size.height-40, self.bounds.size.width, 20);
        _pageControl.numberOfPages = self.gatewayArray.count+1;
        CGPoint offset = _collectionView.contentOffset;
        [_pageControl setCurrentPage:offset.x/_collectionView.bounds.size.width];
        _pageControl.pageIndicatorTintColor = [UIColor grayLineColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

@end
