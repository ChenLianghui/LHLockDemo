//
//  LHManageViewController.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHManageViewController.h"
#import "LHBaseTableViewCell.h"
#import "LHBaseTableModel.h"
#import "LHGatewayListViewController.h"
#import "LHLockListViewController.h"

@interface LHManageViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    BOOL _isPush;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHManageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" isLeft:YES WithBlock:nil];
    
    [self.view addSubview:self.tableView];
    //[self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBaseTableViewCell"];
    if (!cell) {
        cell = [[LHBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LHBaseTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LHGatewayListViewController *gatewayList = [[LHGatewayListViewController alloc] init];
            gatewayList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:gatewayList animated:YES];
        }
            break;
        case 1:
        {
            LHLockListViewController *lockList = [[LHLockListViewController alloc] init];
            lockList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lockList animated:YES];
        }
            break;
        default:
            break;
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kHeightIphone7(50);
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[LHBaseTableViewCell class] forCellReuseIdentifier:@"LHBaseTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_gateway" labelTitle:NSLocalizedString(@"网关列表", nil) rightTitle:nil isHasSwitch:NO]];
        [_dataArray addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_lock" labelTitle:NSLocalizedString(@"锁列表", nil) rightTitle:nil isHasSwitch:NO]];
        
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
