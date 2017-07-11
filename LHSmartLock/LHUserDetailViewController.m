//
//  LHUserDetailViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHUserDetailViewController.h"

@interface LHUserDetailViewController ()

@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)UILabel *detailLabel1;
@property (nonatomic,strong)UILabel *detailLabel2;
@property (nonatomic,strong)UIButton *deleteButton;

@end

@implementation LHUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"用户详情", nil);
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.deleteButton];
    _detailLabel1.text = self.userName;
    _detailLabel2.text = @"2017-6-15";
    // Do any additional setup after loading the view.
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10), kScreenSize.width, kHeightIphone7(84))];
        _mainView.backgroundColor = [UIColor backgroundColor];
        UILabel *titleLabel1 = [UILabel new];
        titleLabel1.text = NSLocalizedString(@"账户名称", nil);
        titleLabel1.font = [UIFont appFontTwo];
        titleLabel1.textColor = [UIColor grayFontColor];
        [_mainView addSubview:titleLabel1];
        
        _detailLabel1 = [UILabel new];
        _detailLabel1.font = [UIFont appFontTwo];
        [_mainView addSubview:_detailLabel1];
        
        UIView *line1 = [UIView new];
        line1.backgroundColor = [UIColor grayLineColor];
        [_mainView addSubview:line1];
        
        UILabel *titleLabel2 = [UILabel new];
        titleLabel2.text = NSLocalizedString(@"授权时间", nil);
        titleLabel2.font = [UIFont appFontTwo];
        titleLabel2.textColor = [UIColor grayFontColor];
        [_mainView addSubview:titleLabel2];
        
        _detailLabel2 = [UILabel new];
        _detailLabel2.font = [UIFont appFontTwo];
        [_mainView addSubview:_detailLabel2];
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = [UIColor grayLineColor];
        [_mainView addSubview:line2];
        
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kBorderMargin);
            make.top.equalTo(kHeightIphone7(10));
            make.width.equalTo(kWidthIphone7(100));
            make.height.equalTo(kHeightIphone7(20));
        }];
        
        if (![LHUtils isCurrentLanguageIsChinese]) {
            [titleLabel1 updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(kWidthIphone7(120));
            }];
        }
        
        [_detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel1.right).offset(kWidthIphone7(20));
            make.top.equalTo(titleLabel1.top);
            make.right.equalTo(-kBorderMargin);
            make.height.equalTo(titleLabel1.height);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainView.left);
            make.right.equalTo(_mainView.right);
            make.height.equalTo(kHeightIphone7(2));
            make.top.equalTo(titleLabel1.bottom).offset(kHeightIphone7(10));
        }];
        
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kBorderMargin);
            make.top.equalTo(line1.bottom).offset(kHeightIphone7(10));
            make.width.equalTo(titleLabel1.width);
            make.height.equalTo(kHeightIphone7(20));
        }];
        
        [_detailLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel2.right).offset(kWidthIphone7(20));
            make.right.equalTo(_mainView.right).offset(-kBorderMargin);
            make.top.equalTo(line1.bottom).offset(kHeightIphone7(10));
            make.height.equalTo(kHeightIphone7(20));
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mainView.left);
            make.right.equalTo(_mainView.right);
            make.top.equalTo(titleLabel2.bottom).offset(kHeightIphone7(10));
            make.height.equalTo(kHeightIphone7(2));
        }];
    }
    return _mainView;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(kScreenSize.width/6, CGRectGetMaxY(self.mainView.frame)+kHeightIphone7(50), 2*kScreenSize.width/3, kHeightIphone7(40));
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = kHeightIphone7(20);
        _deleteButton.backgroundColor = [UIColor appThemeColor];
        [_deleteButton setTitle:NSLocalizedString(@"删除用户", nil) forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)deleteButtonClicked:(UIButton *)button{
    [self showSucceed:NSLocalizedString(@"删除成功", nil) complete:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
