//
//  LHAddLock2ViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddLock2ViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHDeviceService.h"
#import "LHHomeViewController.h"

@interface LHAddLock2ViewController ()

@property (nonatomic,strong)UITextField *passwordTF;
@property (nonatomic,strong)UITextField *againTF;

@end

@implementation LHAddLock2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"添加设备", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTextfiledViews];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"确定", nil) isLeft:NO WithBlock:^{
        [weakSelf NextAction];
    }];
    // Do any additional setup after loading the view.
}

- (void)addTextfiledViews{
    NSArray *array1 = @[NSLocalizedString(@"门锁钥匙", nil),NSLocalizedString(@"确认钥匙", nil)];
    NSArray *array2 = @[NSLocalizedString(@"请输入门锁钥匙密码", nil),NSLocalizedString(@"请再次输入钥匙密码", nil)];
    for (int i = 0; i< array1.count; i++) {
        LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+(kBorderMargin*2+kHeightIphone7(20)+kHeightIphone7(10))*i, kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
        if (i == 0) {
            _passwordTF = textfiledView.textfield;
        }else{
            _againTF = textfiledView.textfield;
        }
        textfiledView.backgroundColor = [UIColor backgroundColor];
        textfiledView.titleLabel.text = array1[i];
        textfiledView.textfield.placeholder = array2[i];
        [self.view addSubview:textfiledView];
    }
}

- (void)NextAction{
    __weak typeof(self)weakSelf = self;
    if (![LHUtils isEmptyStr:_passwordTF.text]) {
        if (![LHUtils isEmptyStr:_againTF.text]) {
            [[LHDeviceService sharedInstance] bindLockWithGateWaySN:[[NSUserDefaults standardUserDefaults] valueForKey:key_currentGatewaySN] andLockSN:self.lockSN andLockName:self.lockname andPassword:_passwordTF.text completed:^(NSURLSessionTask *task, id responseObject) {
                [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeAddLock object:nil];
                [weakSelf showSucceed:NSLocalizedString(@"添加成功", nil) complete:^{
                    for (UIViewController *VC in weakSelf.navigationController.viewControllers) {
                        if ([VC isKindOfClass:[LHHomeViewController class]]) {
                            [weakSelf.navigationController popToViewController:VC animated:YES];
                        }
                    }
                }];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                
            }];
        } else {
            [self showFailed:NSLocalizedString(@"请再次输入钥匙密码", nil)];
        }
    }else{
        [self showFailed:NSLocalizedString(@"请输入门锁钥匙密码", nil)];
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
