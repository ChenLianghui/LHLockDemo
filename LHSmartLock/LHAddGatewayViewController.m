//
//  LHAddGatewayViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddGatewayViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHAddGatewayTwoViewController.h"
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "JXTAlertManagerHeader.h"

@interface LHAddGatewayViewController ()

{
    NSString *_SNString;
}

//@property (nonatomic,strong)LHBaseTextfiledView *textfiledView;
@property (nonatomic,strong) NSDictionary *netInfo;
@property (atomic, strong) ESPTouchTask *_esptouchTask;
@property (nonatomic, strong) NSCondition *_condition;
@property (nonatomic,strong) UITextField *passwordTF;

@end

@implementation LHAddGatewayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.netInfo = [self fetchNetInfo];
    if (self.netInfo) {
        
    }
    self.bssid = [self.netInfo objectForKey:@"BSSID"];
    self.ssid = [self.netInfo objectForKey:@"SSID"];
    self.title = NSLocalizedString(@"添加网关", nil);
    _passwordTF = [UITextField new];
    [self addTextfiledViews];
    
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"下一步", nil) isLeft:NO WithBlock:^{
        [weakSelf getSNString];
        
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
    NSArray *array1 = @[@"SSID",NSLocalizedString(@"密码", nil)];
    NSArray *array2 = @[NSLocalizedString(@"请输入SSID名称", nil),NSLocalizedString(@"请输入SSID密码", nil)];
    for (int i = 0; i< array1.count; i++) {
        LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+(kBorderMargin*2+kHeightIphone7(20)+kHeightIphone7(10))*i, kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
        if (i == 0) {
            textfiledView.textfield.userInteractionEnabled = NO;
            
            textfiledView.textfield.text = [self.netInfo objectForKey:@"SSID"];
            self.bssid = [self.netInfo objectForKey:@"BSSID"];
        }else{
            _passwordTF = textfiledView.textfield;
        }
        textfiledView.backgroundColor = [UIColor backgroundColor];
        textfiledView.titleLabel.text = array1[i];
        textfiledView.textfield.tag = 70+i;
        textfiledView.textfield.placeholder = array2[i];
        [self.view addSubview:textfiledView];
    }
}

- (NSDictionary *)fetchNetInfo{
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    //    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        //        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}

- (void)getSNString{
//    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSLog(@"ESPViewController do the execute work...");
//        // execute the task
//        ESPTouchResult *esptouchResult = [self executeForResult];
//        // show the result to the user in UI Main Thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // when canceled by user, don't show the alert view again
////            if (!esptouchResult.isCancelled)
////            {
////                [[[UIAlertView alloc] initWithTitle:@"Execute Result" message:[esptouchResult description] delegate:nil cancelButtonTitle:@"I know" otherButtonTitles: nil] show];
////            }
//            _SNString = [esptouchResult description];
//            [self NextAction];
//        });
//    });
    [self showWaitLoading];
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"ESPViewController do the execute work...");
        // execute the task
        NSArray *esptouchResultArray = [self executeForResults];
        // show the result to the user in UI Main Thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ESPTouchResult *firstResult = [esptouchResultArray objectAtIndex:0];
            // check whether the task is cancelled and no results received
            if (!firstResult.isCancelled)
            {
                NSMutableString *mutableStr = [[NSMutableString alloc]init];
                NSUInteger count = 0;
                // max results to be displayed, if it is more than maxDisplayCount,
                // just show the count of redundant ones
                const int maxDisplayCount = 5;
                if ([firstResult isSuc])
                {
                    
                    for (int i = 0; i < [esptouchResultArray count]; ++i)
                    {
                        ESPTouchResult *resultInArray = [esptouchResultArray objectAtIndex:i];
//                        [mutableStr appendString:[resultInArray description]];
//                        [mutableStr appendString:@"\n"];
                        _SNString = [resultInArray description];
                        count++;
                        if (count >= maxDisplayCount)
                        {
                            break;
                        }
                    }
                    
                    if (count < [esptouchResultArray count])
                    {
                        [mutableStr appendString:[NSString stringWithFormat:@"\nthere's %lu more result(s) without showing\n",(unsigned long)([esptouchResultArray count] - count)]];
                    }
                    [self hideLoading];
                    [self NextAction];
                }
                
                else
                {
                    [[[UIAlertView alloc]initWithTitle:@"Execute Result" message:@"Esptouch fail" delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil]show];
                    
                }
                
            }
            
        });
    });
}


- (NSArray *) executeForResults
{
    [self._condition lock];
    NSString *apSsid = self.ssid;
    NSString *apPwd = self.passwordTF.text;
    NSString *apBssid = self.bssid;
    int taskCount = 1;
    self._esptouchTask =
    [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd];
    // set delegate
//    [self._esptouchTask setEsptouchDelegate:self._esptouchDelegate];
    [self._condition unlock];
    NSArray * esptouchResults = [self._esptouchTask executeForResults:taskCount];
    NSLog(@"ESPViewController executeForResult() result is: %@",esptouchResults);
    return esptouchResults;
}

//- (ESPTouchResult *) executeForResult
//{
//    [self._condition lock];
//    NSString *apSsid = self.ssid;
//    NSString *apPwd = self.passwordTF.text;
//    NSString *apBssid = self.bssid;
//    self._esptouchTask =
//    [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd];
//    // set delegate
//    [self._condition unlock];
//    ESPTouchResult * esptouchResult = [self._esptouchTask executeForResult];
//    NSLog(@"ESPViewController executeForResult() result is: %@",esptouchResult);
//    return esptouchResult;
//}


- (void)NextAction{
    UITextField *textfield1 = (UITextField *)[self.view viewWithTag:70];
    UITextField *textfield2 = (UITextField *)[self.view viewWithTag:71];
    LHAddGatewayTwoViewController *addGateWay = [[LHAddGatewayTwoViewController alloc] init];
    addGateWay.SNStr = _SNString;
    [self.navigationController pushViewController:addGateWay animated:YES];
    NSLog(@"%@",textfield1.text);
    NSLog(@"%@",textfield2.text);
}

- (NSDictionary *)netInfo{
    if (!_netInfo) {
        _netInfo = [[NSDictionary alloc] init];
        
    }
    return _netInfo;
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
