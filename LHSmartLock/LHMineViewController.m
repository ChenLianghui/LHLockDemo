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

#define kPhoneNumber @"17606547695"
@interface LHMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,copy)NSArray *dataArray;

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
        cell.rightLabel.text = [LHUserModel sharedInstance].name;
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

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = kHeightIphone7(40);
        _tableview.tableFooterView = [UIView new];
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
