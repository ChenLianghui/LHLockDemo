//
//  LHAddGatewayTwoViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/25.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddGatewayTwoViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHDeviceService.h"
#import "LHHomeViewController.h"
#import "JXTAlertManagerHeader.h"

@interface LHAddGatewayTwoViewController ()

//@property (nonatomic,strong)LHBaseTextfiledView *textView
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *placeholderArray;
@property (nonatomic,strong)UITextField *nameTextfield;

@end

@implementation LHAddGatewayTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"添加网关", nil);
    self.titleArray = @[NSLocalizedString(@"网关名称", nil),NSLocalizedString(@"网关序列号", nil)];
    self.placeholderArray = @[NSLocalizedString(@"请输入网关名称", nil),NSLocalizedString(@"请输入网关序列号", nil)];
    [self addTextfiledViews];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"下一步", nil) isLeft:NO WithBlock:^{
        [weakSelf NextAction];
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self TestCurrentNetIsWifi];
}

#pragma mark - 检测网络是否是WiFi
- (void)TestCurrentNetIsWifi{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:userDefault_isConnectWifi]) {
        [self jxt_showAlertWithTitle:NSLocalizedString(@"您当前没有连接WiFi", nil) message:NSLocalizedString(@"是否去设置", nil) appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(NSLocalizedString(@"取消", nil)).addActionDefaultTitle(NSLocalizedString(@"去设置", nil));
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
    }
}


- (void)addTextfiledViews{
    for (int i = 0; i < self.titleArray.count; i++) {
        LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+(kBorderMargin*2+kHeightIphone7(20)+kHeightIphone7(10))*i, kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
        textfiledView.backgroundColor = [UIColor backgroundColor];
        textfiledView.titleLabel.text = self.titleArray[i];
        if (i == 0) {
            textfiledView.textfield.placeholder = self.placeholderArray[0];
            _nameTextfield = textfiledView.textfield;
        }else{
            textfiledView.textfield.text = self.SNStr;
            textfiledView.textfield.userInteractionEnabled = NO;
            textfiledView.textfield.placeholder = @"";
        }
        
        [self.view addSubview:textfiledView];
    }
}

- (void)NextAction{
    if ([LHUtils isEmptyStr:_nameTextfield.text]) {
        [self showFailed:NSLocalizedString(@"网关名称不能为空", nil)];
    }else{
        __weak typeof(self)weakSelf = self;
        [[LHDeviceService sharedInstance] bindGateWayWithSN:weakSelf.SNStr andGateWayName:weakSelf.nameTextfield.text completed:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            [weakSelf showSucceed:NSLocalizedString(@"网关绑定成功", nil) complete:^{
                            for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                                if ([vc isKindOfClass:[LHHomeViewController class]]) {
                                    [weakSelf.navigationController popToViewController:vc animated:YES];
                                }
                            }
            }];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
    }
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
