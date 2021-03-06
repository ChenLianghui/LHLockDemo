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
#import "LHTemporaryPasswordViewController.h"
#import "LHAuthorUserViewController.h"
#import "LHChangeLockNameViewController.h"
#import "LHRemoteControlViewController.h"
#import "LHDeviceService.h"

@interface LHLockDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHLockDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"锁详情", nil);
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
        [array2 addObject:[LHBaseTableModel initBaseModelWithIconName:@"" labelTitle:NSLocalizedString(@"遥控器", nil) rightTitle:@"" isHasSwitch:NO]];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 2) {
        if ([self.lockModel.alarm isEqualToString:@"open"]) {
            [cell.ASwitch setOn:YES animated:YES];
        }else{
            [cell.ASwitch setOn:NO animated:YES];
        }
        UISwitch *aswitch = cell.ASwitch;
        __weak typeof(self)weakSelf = self;
        cell.switchBlock = ^(BOOL isOn){
            NSString *state;
            if (isOn) {
                state = @"open";
                NSLog(@"yes");
            }else{
                state = @"close";
                NSLog(@"no");
            }
            [weakSelf changeAlarmToState:state withSwitch:aswitch];
        };
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                LHChangeLockNameViewController *changeLockVC = [[LHChangeLockNameViewController alloc] init];
                changeLockVC.lockModel = self.lockModel;
                [self.navigationController pushViewController:changeLockVC animated:YES];
            }
                break;
            case 1:
            {
                LHRemoteControlViewController *remoteVC = [[LHRemoteControlViewController alloc] init];
                [self.navigationController pushViewController:remoteVC animated:YES];
            }
                break;
            case 2:{
                LHChangeLockPasswordViewController *changePassword = [[LHChangeLockPasswordViewController alloc] init];
                changePassword.lockModel = self.lockModel;
                [self.navigationController pushViewController:changePassword animated:YES];
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            LHTemporaryPasswordViewController *temporaryVC = [[LHTemporaryPasswordViewController alloc] init];
            temporaryVC.lockModel = self.lockModel;
            [self.navigationController pushViewController:temporaryVC animated:YES];
        }else{
            LHAuthorUserViewController *authorVC = [[LHAuthorUserViewController alloc] init];
            authorVC.lockModel = self.lockModel;
            [self.navigationController pushViewController:authorVC animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(20))];
    return view;
}

- (void)changeAlarmToState:(NSString *)state withSwitch:(UISwitch *)Aswitch{
    [[LHDeviceService sharedInstance] lockAlarmSettingWithGatewaySN:nil andLockSN:self.lockModel.lockSn andAlarm:state completed:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"resonseObject:%@",responseObject);
//        if ([state isEqualToString:@"open"]) {
//            [Aswitch setOn:NO animated:YES];
//        }else{
//            [Aswitch setOn:YES animated:YES];
//        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
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
