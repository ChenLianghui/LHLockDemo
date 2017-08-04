//
//  LHLockListView.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/9.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLockListView.h"
#import "LHLockModel.h"
#import "LHSelectLockCollectionViewCell.h"
#define kLineHeight kHeightIphone7(6)
#define kIndicateViewHeight kHeightIphone7(8)
#define kViewSpace kWidthIphone7(1)

//上方线条区域
@interface LHIndicateView : UIScrollView

@property (nonatomic,strong)UIView *lineView;

@end

@implementation LHIndicateView

- (instancetype)init{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kScreenSize.width, kIndicateViewHeight);
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor grayLineColor];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (kScreenSize.width-3*kViewSpace)/4, kLineHeight)];
        _lineView.layer.masksToBounds = YES;
        _lineView.layer.cornerRadius = kLineHeight/2.0;
        _lineView.backgroundColor = [UIColor appThemeColor];
    }
    return _lineView;
}

@end

@interface LHLockListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)LHIndicateView *indicateView;
@property (nonatomic,assign)CGFloat itemWidth;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)NSIndexPath *selectIndexPath;//选择item的indexpath

@end

@implementation LHLockListView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor grayLineColor];
        _selectIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        _itemWidth = (kScreenSize.width-3*kViewSpace)/4;
        self.bounds = CGRectMake(0, 0, kScreenSize.width, _itemWidth+kIndicateViewHeight);
        _indicateView = [[LHIndicateView alloc] init];
        _lineView = [[UIView alloc] init];
        _lineView = self.indicateView.lineView;
        [self addSubview:_indicateView];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.lockArray.count != 0 ? self.lockArray.count : 1;
    return self.lockArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LHSelectLockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHSelectLockCollectionViewCell" forIndexPath:indexPath];
    
    if (self.lockArray.count == 0) {
        cell.isEmpty = YES;
    }else if(self.lockArray.count == indexPath.row){
        cell.isEmpty = YES;
        
    }else{
        LHLockModel *model = self.lockArray[indexPath.item];
        cell.model = model;
        if (_selectIndexPath == indexPath) {
            //            cell.contentView.backgroundColor = [UIColor appThemeColor];
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ListViewDidTapItemWithIndex:)]) {
        [self.delegate ListViewDidTapItemWithIndex:indexPath.item];
    }
    if (self.lockArray.count == 0 || self.lockArray.count == indexPath.row) {
        return;
    }
    LHSelectLockCollectionViewCell *cell = (LHSelectLockCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    LHSelectLockCollectionViewCell *selectedCell = (LHSelectLockCollectionViewCell *)[collectionView cellForItemAtIndexPath:_selectIndexPath];
    selectedCell.isSelected = NO;
    cell.isSelected = YES;
    _selectIndexPath = indexPath;
    CGFloat x = cell.center.x;
    CGFloat contentWidth = self.collectionView.contentSize.width;
    NSIndexPath *indexPath1;
    if (x<=kScreenSize.width/2) {
        if (collectionView.contentOffset.x == 0) {
            [self LineViewScrollToX:x];
            return;
        }else{
            indexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }else if (x>=contentWidth-kScreenSize.width/2){
        if (collectionView.contentOffset.x == collectionView.contentSize.width-kScreenSize.width) {
            [self LineViewScrollToX:x];
            return;
        }else{
            indexPath1 = [NSIndexPath indexPathForItem:self.lockArray.count-1 inSection:0];
        }
        
    }else{
        //collectionview滚动
        indexPath1 = indexPath;
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath1 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self LineViewScrollToX:x];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        [self.indicateView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, 0) animated:NO];
    }
}

//线条动画
- (void)LineViewScrollToX:(CGFloat )x {
    
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = _lineView.center;
        center.x = x;
        _lineView.center = center;
    }];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //因为为水平滚动，需要设置lineSpacing
        layout.minimumLineSpacing = kViewSpace;
        //        layout.minimumInteritemSpacing = kViewSpace;
        layout.itemSize = CGSizeMake(_itemWidth, _itemWidth);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kIndicateViewHeight, kScreenSize.width, _itemWidth) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[LHSelectLockCollectionViewCell class] forCellWithReuseIdentifier:@"LHSelectLockCollectionViewCell"];
    }
    return _collectionView;
}

- (void)setLineColor:(UIColor *)lineColor{
    self.lineView.backgroundColor = lineColor;
}

- (void)setLineHeight:(CGFloat)lineHeight{
    CGRect frame = self.lineView.frame;
    CGPoint center = self.lineView.center;
    frame.size.height = lineHeight;
    self.lineView.frame = frame;
    self.lineView.center = center;
}

- (void)setLineWidth:(CGFloat)lineWidth{
    CGRect frame = self.lineView.frame;
    CGPoint center = self.lineView.center;
    frame.size.width = lineWidth;
    self.lineView.frame = frame;
    self.lineView.center = center;
}

- (void)setLockArray:(NSMutableArray *)lockArray{
    if (lockArray.count!=0) {
        if (_lockArray != lockArray) {
            _lockArray = lockArray;
            _selectIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [self LineViewScrollToX:kScreenSize.width/8];
        }
    }else{
        _selectIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self LineViewScrollToX:kScreenSize.width/8];
    }
    
    [self.collectionView reloadData];
}


@end
