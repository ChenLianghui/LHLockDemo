//
//  LHGatewayDetailViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/7/17.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHGatewayDetailViewController.h"
#import "LHBaseTableViewCell.h"
#import "LHeditGatewayViewController.h"

@interface LHGatewayDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHGatewayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = NSLocalizedString(@"网关详情", nil);
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBaseTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    cell.switchBlock = ^(BOOL isOn){
        NSLog(@"changeAlert");
        if (isOn) {
            NSLog(@"yes");
        }else{
            NSLog(@"no");
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        LHeditGatewayViewController *editGatewayVC = [[LHeditGatewayViewController alloc] init];
        editGatewayVC.gatewayModel = self.gatewayModel;
        [self.navigationController pushViewController:editGatewayVC animated:YES];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kHeightIphone7(40);
        [_tableView registerClass:[LHBaseTableViewCell class] forCellReuseIdentifier:@"LHBaseTableViewCell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
        LHBaseTableModel *tableModel = [LHBaseTableModel initBaseModelWithIconName:@"" labelTitle:NSLocalizedString(@"序列号", nil) rightTitle:self.gatewayModel.gatewaySn isHasSwitch:NO];
        LHBaseTableModel *tableModel1 = [LHBaseTableModel initBaseModelWithIconName:@"" labelTitle:NSLocalizedString(@"设备名", nil) rightTitle:@"" isHasSwitch:NO];
        LHBaseTableModel *tableModel2 = [LHBaseTableModel initBaseModelWithIconName:@"" labelTitle:NSLocalizedString(@"设备入网", nil) rightTitle:@"" isHasSwitch:YES];
        _dataArray = [NSMutableArray arrayWithObjects:tableModel,tableModel1,tableModel2, nil];
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
