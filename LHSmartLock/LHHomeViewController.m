//
//  LHHomeViewController.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHHomeViewController.h"
#import "JXTAlertManagerHeader.h"
#import "LHLoginViewController.h"
#import "LHSelectGatewayCollectionViewCell.h"
#import "LHGatewayModel.h"
#import "LHHomeHeaderView.h"
#import "LHLockListView.h"
#import "LHLockModel.h"
#import "LHAddGatewayViewController.h"
#import "LHAddLock1ViewController.h"
#import "LHRecordListViewController.h"
#import "LHMessageListViewController.h"

#define kGatewayCellId @"gatewayCellId"
#define kLockCellId @"lockCellId"

@interface LHHomeViewController ()<LHHomeHeaderViewDelegate,LHLockListViewDelegate>

{
    NSInteger _selectedIndex;
}

@property (nonatomic, strong)NSMutableArray *gatewayArray;
@property (nonatomic, strong)LHHomeHeaderView *headerView;
@property (nonatomic, strong)LHLockListView *lockListView;
@property (nonatomic, strong)NSMutableArray *lockListArray;
@property (nonatomic, strong)UIButton *actionButton;

@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
//    [self addItemWithName:@"login" isLeft:NO WithBlock:^{
////        LHLoginViewController *loginVC = [[LHLoginViewController alloc] init];
////        loginVC.hidesBottomBarWhenPushed = YES;
////        [weakSelf.navigationController pushViewController:loginVC animated:YES];
//        LHGatewayModel *model = [LHGatewayModel new];
//        model.name = @"TPLink-new";
//        [weakSelf.gatewayArray addObject:model];
//        weakSelf.headerView.gatewayArray = weakSelf.gatewayArray;
////        [weakSelf.headerView reloadGatewayDate];
//    }];
//    [self addItemWithName:@"jian" isLeft:YES WithBlock:^{
//        //        LHLoginViewController *loginVC = [[LHLoginViewController alloc] init];
//        //        loginVC.hidesBottomBarWhenPushed = YES;
//        //        [weakSelf.navigationController pushViewController:loginVC animated:YES];
//        if (weakSelf.gatewayArray.count>0) {
//            [weakSelf.gatewayArray removeLastObject];
//            weakSelf.headerView.gatewayArray = weakSelf.gatewayArray;
////            [weakSelf.headerView reloadGatewayDate];
//        }
//    }];
    [self addImageWithName:@"record" isLeft:YES WithBlock:^{
        LHRecordListViewController *recordVC = [[LHRecordListViewController alloc] init];
        recordVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:recordVC animated:YES];
    }];
    
    [self addImageWithName:@"message" isLeft:NO WithBlock:^{
        LHMessageListViewController *messageVC = [[LHMessageListViewController alloc] init];
        messageVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:messageVC animated:YES];
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 40);
    button.center = self.view.center;
    [button setTitle:@"检测网络" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    [self testNetwork];
    
    self.view.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.lockListView];
    if (self.lockListArray.count != 0) {
        LHLockModel *model = self.lockListArray.firstObject;
        if (model.isLock) {
            [self.actionButton setTitle:NSLocalizedString(@"关锁", nil) forState:UIControlStateNormal];
        }else{
            [self.actionButton setTitle:NSLocalizedString(@"开锁", nil) forState:UIControlStateNormal];
        }
        [self.view addSubview:self.actionButton];
    }
    _selectedIndex = 0;
    // Do any additional setup after loading the view.
}

- (void)testNetwork{
    //获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:userDefault_isConnectWifi];
                NSLog(@"WiFi！");
                break;
            default:
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:userDefault_isConnectWifi];
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

- (void)buttonClicked{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:userDefault_isConnectWifi]) {
        [self jxt_showAlertWithTitle:@"您当前没有连接WiFi" message:@"是否去设置" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(@"取消").addActionDefaultTitle(@"去设置");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"取消");
            }else if (buttonIndex == 1){
                NSLog(@"去设置");
                NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
                float version = [[[UIDevice currentDevice] systemVersion] floatValue];
                if (version >= 10.0) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }else{
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
                
            }
        }];
    }else{
        [self jxt_showAlertWithTitle:@"当前连接为WIFI" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 1;
            
        } actionsBlock:NULL];
    }
}


#pragma mark - LHHomeHeaderViewDelegate
- (void)hadChangeGatewayWithIndex:(NSInteger)index{
    NSLog(@"index:%ld",index);
}

- (void)hadClickedTheEmptyGateway{
    LHAddGatewayViewController *addGatewayVC = [[LHAddGatewayViewController alloc] init];
    addGatewayVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addGatewayVC animated:YES];
}

#pragma mark - LHLockListViewDelegate

- (void)ListViewDidTapItemWithIndex:(NSInteger)index{
    _selectedIndex = index;
    if (self.lockListArray.count == 0 && index == 0) {
        NSLog(@"添加锁");
        LHAddLock1ViewController *addlock = [[LHAddLock1ViewController alloc] init];
        addlock.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addlock animated:YES];
    }else{
        NSLog(@"点击了第%ld个锁",index);
        LHLockModel *model = self.lockListArray[index];
        if (model.isLock) {
            [self.actionButton setTitle:NSLocalizedString(@"关锁", nil) forState:UIControlStateNormal];
        }else{
            [self.actionButton setTitle:NSLocalizedString(@"开锁", nil) forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 点击开锁（关锁）
- (void)actionButtonClicked:(UIButton *)button{
    NSLog(@"第%ld把锁%@",_selectedIndex+1,button.titleLabel.text);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"门锁", nil) message:NSLocalizedString(@"请输入门锁密码", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = NSLocalizedString(@"请确认密码", nil);
    }];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertVC.textFields[0];
        NSLog(@"%@",textField.text);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:defaultAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (LHHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LHHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(200))];
        _headerView.delegate = self;
        _headerView.gatewayArray = self.gatewayArray;
    }
    return _headerView;
}

- (NSMutableArray *)gatewayArray{
    if (!_gatewayArray) {
        _gatewayArray = [NSMutableArray array];
        //        for (int i = 0; i < 3; i++) {
        //            LHGatewayModel *model = [LHGatewayModel new];
        //            model.name = [NSString stringWithFormat:@"TPLink%i",i+1];
        //            [_gatewayArray addObject:model];
        //        }
    }
    return _gatewayArray;
}

- (LHLockListView *)lockListView{
    if (!_lockListView) {
        _lockListView = [[LHLockListView alloc] init];
        _lockListView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), _lockListView.bounds.size.width, _lockListView.bounds.size.height);
//        _lockListView.lineColor = [UIColor appThemeColor];
        _lockListView.delegate = self;
        _lockListView.lockArray = self.lockListArray;
        _lockListView.lineWidth = kWidthIphone7(40);
    }
    return _lockListView;
}

- (NSMutableArray *)lockListArray{
    if (!_lockListArray) {
        _lockListArray = [NSMutableArray array];
        for (int i = 0; i < 8; i ++) {
            LHLockModel *model = [[LHLockModel alloc] init];
            model.isLock = arc4random()%2 == 0? YES : NO;
            model.name = [NSString stringWithFormat:@"大门%d",i+1];
            model.electricNumber = 2*(arc4random()%3+1)-1;
            [_lockListArray addObject:model];
        }
    }
    return _lockListArray;
}

- (UIButton *)actionButton{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.frame = CGRectMake(kScreenSize.width/4, CGRectGetMaxY(self.lockListView.frame)+kHeightIphone7(50), kScreenSize.width/2, kHeightIphone7(40));
        _actionButton.layer.masksToBounds = YES;
        _actionButton.layer.borderColor = [UIColor naviBackColor].CGColor;
        _actionButton.layer.borderWidth = 2.0f;
        _actionButton.layer.cornerRadius = kHeightIphone7(20);
        [_actionButton setTitleColor:[UIColor naviBackColor] forState:UIControlStateNormal];
        _actionButton.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
        _actionButton.titleLabel.font = [UIFont appFontTwo];
        [_actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
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
