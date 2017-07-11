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
#import "LHLoginService.h"
#import "LHDeviceService.h"

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
    [self testNetwork];
    [self TestCurrentNetIsWifi];
    [self getGatewayData];
    
    self.view.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.lockListView];
    [self.view addSubview:self.actionButton];
    _selectedIndex = 0;
    [self tokenLogin];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

#pragma mark - 检测网络
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
                NSLog(@"4g!");
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

#pragma mark - 检测网络是否是WiFi
- (void)TestCurrentNetIsWifi{
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

#pragma mark - 获取网关列表数据
- (void)getGatewayData{
    __weak typeof(self)weakSelf = self;
    [[LHDeviceService sharedInstance] findAllGatewayCompleted:^(NSURLSessionTask *task, id responseObject) {
        [weakSelf.gatewayArray removeAllObjects];
        NSArray *array = [responseObject valueForKey:@"data"];
        for (NSDictionary *dict in array) {
            LHGatewayModel *model = [LHGatewayModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.gatewayArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.headerView.gatewayArray = self.gatewayArray;
        });
        if (weakSelf.gatewayArray.count != 0) {
            LHGatewayModel *model = weakSelf.gatewayArray[0];
            [weakSelf getLockDataWithSNString:model.gatewaySn];
            [[NSUserDefaults standardUserDefaults] setValue:model.gatewaySn forKey:key_currentGatewaySN];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.lockListView.lockArray = nil;
            });
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

#pragma mark - 获取某个网关下的锁的数据
- (void)getLockDataWithSNString:(NSString *)SN{
//    [self showWaitLoading];
    __weak typeof(self)weakSelf = self;
    [[LHDeviceService sharedInstance] findAllLockUnderTheGatewaySN:SN completed:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NSArray *array = [responseObject valueForKey:@"data"];
        [weakSelf.lockListArray removeAllObjects];
        for (NSDictionary *dict in array) {
            LHLockModel *model = [LHLockModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.lockListArray addObject:model];
        }
        LHLockModel *lockModel = [LHLockModel new];
        lockModel.online = YES;
        lockModel.lockName = @"test1";
        lockModel.lockSn = @"salfiowoe";
        lockModel.power = @"middle";
        lockModel.status = @"open";
        [weakSelf.lockListArray addObject:lockModel];
        LHLockModel *lockModel2 = [LHLockModel new];
        lockModel2.online = YES;
        lockModel2.lockName = @"test2";
        lockModel2.lockSn = @"f32sd23";
        lockModel2.power = @"high";
        lockModel2.status = @"close";
        [weakSelf.lockListArray addObject:lockModel2];
        weakSelf.lockListView.lockArray = weakSelf.lockListArray;
        if (weakSelf.lockListArray.count != 0) {
            LHLockModel *model = weakSelf.lockListArray.firstObject;
                if ([model.status isEqualToString:@"open"]) {
                    [weakSelf.actionButton setTitle:NSLocalizedString(@"关锁", nil) forState:UIControlStateNormal];
                }else if([model.status isEqualToString:@"close"]){
                    [weakSelf.actionButton setTitle:NSLocalizedString(@"开锁", nil) forState:UIControlStateNormal];
                }else{
                    [self.actionButton setTitle:NSLocalizedString(@"该锁已离线", nil) forState:UIControlStateNormal];
                    self.actionButton.userInteractionEnabled = NO;
                }
                weakSelf.actionButton.hidden = NO;
            
        }else{
            weakSelf.actionButton.hidden = YES;
        }
//        [weakSelf hideLoading];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        [weakSelf hideLoading];
    }];
}

#pragma mark - LHHomeHeaderViewDelegate

#pragma mark - 点击了某个网关
- (void)hadChangeGatewayWithIndex:(NSInteger)index{
    NSLog(@"index:%ld",index);
    if (index != self.gatewayArray.count) {
        LHGatewayModel *gatewayModel = self.gatewayArray[index];
        [[NSUserDefaults standardUserDefaults] setValue:gatewayModel.gatewaySn forKey:key_currentGatewaySN];
        [self getLockDataWithSNString:gatewayModel.gatewaySn];
    }else{
        [self.lockListArray removeAllObjects];
        self.lockListView.lockArray = self.lockListArray;
        self.actionButton.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:key_currentGatewaySN];
    }
    
}
#pragma mark - 点击了空的网关(新增网关)
- (void)hadClickedTheEmptyGateway{
    LHAddGatewayViewController *addGatewayVC = [[LHAddGatewayViewController alloc] init];
    addGatewayVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addGatewayVC animated:YES];
}

#pragma mark - LHLockListViewDelegate
#pragma mark - 点击了某把锁
- (void)ListViewDidTapItemWithIndex:(NSInteger)index{
    
    if ((self.lockListArray.count == 0 && index == 0)||self.lockListArray.count == index) {
        NSLog(@"添加锁");
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:key_currentGatewaySN] isEqualToString:@""]) {
            [self showFailed:@"请先添加一个网关"];
            return;
        }
        LHAddLock1ViewController *addlock = [[LHAddLock1ViewController alloc] init];
//        LHLockModel *model = self.lockListArray[index];
//        addlock.currentGatewaySN = model.;
        addlock.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addlock animated:YES];
    }else{
        _selectedIndex = index;
        NSLog(@"点击了第%ld个锁",index);
        LHLockModel *model = self.lockListArray[index];
        if (model.online) {
            if ([model.status isEqualToString:@"close"]) {
                [self.actionButton setTitle:NSLocalizedString(@"开锁", nil) forState:UIControlStateNormal];
            }else if ([model.status isEqualToString:@"open"]){
                [self.actionButton setTitle:NSLocalizedString(@"关锁", nil) forState:UIControlStateNormal];
            }
            self.actionButton.userInteractionEnabled = YES;
        }else{
            [self.actionButton setTitle:NSLocalizedString(@"该锁已离线", nil) forState:UIControlStateNormal];
            self.actionButton.userInteractionEnabled = NO;
        }
        
    }
}

#pragma mark - 点击开锁（关锁）
- (void)actionButtonClicked:(UIButton *)button{
    NSLog(@"第%ld把锁%@",_selectedIndex+1,button.titleLabel.text);
    LHLockModel *lockModel = self.lockListArray[_selectedIndex];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:lockModel.lockName message:NSLocalizedString(@"请输入门锁密码", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = NSLocalizedString(@"请确认密码", nil);
    }];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertVC.textFields[0];
        NSLog(@"%@",textField.text);
        [self commitAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:defaultAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - 点击确定
- (void)commitAction{
    LHLockModel *lockModel = self.lockListArray[_selectedIndex];
    NSString *successStr;
    if ([lockModel.status isEqualToString:@"open"]) {
        successStr = NSLocalizedString(@"门锁已开启", nil);
    }else if([lockModel.status isEqualToString:@"close"]){
        successStr = NSLocalizedString(@"门锁已关闭", nil);
    }
    [self showSucceed:successStr complete:^{
        if ([lockModel.status isEqualToString:@"open"]) {
            [self.actionButton setTitle:NSLocalizedString(@"关锁", nil) forState:UIControlStateNormal];
        }else if([lockModel.status isEqualToString:@"close"]){
            [self.actionButton setTitle:NSLocalizedString(@"开锁", nil) forState:UIControlStateNormal];
        }
//        lockModel.isLock = !lockModel.isLock;
        [self.lockListArray replaceObjectAtIndex:_selectedIndex withObject:lockModel];
        [_lockListView.collectionView reloadData];
    }];
}

#pragma mark - token登录
- (void)tokenLogin{
    [[LHLoginService sharedInstance] loginWithTokenCompleted:^(NSURLSessionTask *task, id responseObject) {
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

- (LHHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LHHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(200))];
        _headerView.delegate = self;
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
//        for (int i = 0; i < 8; i ++) {
//            LHLockModel *model = [[LHLockModel alloc] init];
//            model.isLock = arc4random()%2 == 0? YES : NO;
//            model.name = [NSString stringWithFormat:@"大门%d",i+1];
//            model.electricNumber = 2*(arc4random()%3+1)-1;
//            [_lockListArray addObject:model];
//        }
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
