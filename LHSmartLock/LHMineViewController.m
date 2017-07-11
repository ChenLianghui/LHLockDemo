//
//  LHMineViewController.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHMineViewController.h"
#import "LHUserModel.h"
#import "LHMineTableViewCell.h"
#import "LHLoginViewController.h"

#define kPhoneNumber @"17606547695"
@interface LHMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,copy)NSArray *dataArray;
@property (nonatomic,strong)UIButton *logoutButton;
@property (nonatomic,strong)UIView *logoutView;

@end

@implementation LHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" isLeft:YES WithBlock:nil];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMineTableViewCell"];
    if (!cell) {
        cell = [[LHMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LHMineTableViewCell"];
    }
    cell.titleLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.rightLabel.text = [LHUserModel sharedInstance].username;
    }else{
        cell.rightLabel.text = kPhoneNumber;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:
        {
            [LHUtils callTelephoneWithString:kPhoneNumber];
        }
            break;
            
        default:
            break;
    }
}

- (void)logoutAction{
    [[LHUserModel sharedInstance] logout];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:[[LHLoginViewController alloc] init]];
    [self presentViewController:loginNav animated:YES completion:nil];
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = kHeightIphone7(40);
        _tableview.tableFooterView = self.logoutView;
        [_tableview registerClass:[LHMineTableViewCell class] forCellReuseIdentifier:@"LHMineTableViewCell"];
    }
    return _tableview;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[NSLocalizedString(@"账号", nil),NSLocalizedString(@"客服电话", nil)];
    }
    return _dataArray;
}

- (UIView *)logoutView{
    if (!_logoutView) {
        _logoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(60))];
        _logoutView.backgroundColor = [UIColor clearColor];
        [_logoutView addSubview:self.logoutButton];
    }
    return _logoutView;
}

- (UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame = CGRectMake(kScreenSize.width/6, kHeightIphone7(20), kScreenSize.width*2/3, kHeightIphone7(40));
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = kHeightIphone7(20);
        _logoutButton.backgroundColor = [UIColor appThemeColor];
        [_logoutButton setTitle:NSLocalizedString(@"退出登录", nil) forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
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
