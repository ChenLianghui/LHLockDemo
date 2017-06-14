//
//  LHLockDetailViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/13.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLockDetailViewController.h"
#import "LHBaseTableViewCell.h"
#import "LHBaseTableModel.h"
#import "LHChangeLockPasswordViewController.h"

@interface LHLockDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHLockDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kHeightIphone7(40);
        [_tableView registerClass:[LHBaseTableViewCell class] forCellReuseIdentifier:@"LHBaseTableViewCell"];
        _tableView.sectionHeaderHeight = kHeightIphone7(20);
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSMutableArray *array1 = [NSMutableArray array];
        [array1 addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_SN" labelTitle:NSLocalizedString(@"SN序列号", nil) rightTitle:@"12345678" isHasSwitch:NO]];
        NSMutableArray *array2 = [NSMutableArray array];
        [array2 addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_name" labelTitle:NSLocalizedString(@"设备名", nil) rightTitle:nil isHasSwitch:NO]];
        [array2 addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_password" labelTitle:NSLocalizedString(@"修改密码", nil) rightTitle:nil isHasSwitch:NO]];
        NSMutableArray *array3 = [NSMutableArray array];
        [array3 addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_alarm" labelTitle:NSLocalizedString(@"自动报警", nil) rightTitle:nil isHasSwitch:YES]];
        NSMutableArray *array4 = [NSMutableArray array];
        [array4 addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_tpassword" labelTitle:NSLocalizedString(@"临时密码", nil) rightTitle:nil isHasSwitch:NO]];
        [array4 addObject:[LHBaseTableModel initBaseModelWithIconName:@"manage_user" labelTitle:NSLocalizedString(@"授权用户", nil) rightTitle:nil isHasSwitch:NO]];
        [_dataArray addObject:array1];
        [_dataArray addObject:array2];
        [_dataArray addObject:array3];
        [_dataArray addObject:array4];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSMutableArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBaseTableViewCell"];
    if (!cell) {
        cell = [[LHBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LHBaseTableViewCell"];
    }
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 1:
            {
                LHChangeLockPasswordViewController *changePassword = [[LHChangeLockPasswordViewController alloc] init];
                [self.navigationController pushViewController:changePassword animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(20))];
    return view;
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
