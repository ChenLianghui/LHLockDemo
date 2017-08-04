//
//  LHChangeLockNameViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHChangeLockNameViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHDeviceService.h"

@interface LHChangeLockNameViewController ()

@property (nonatomic,strong)UITextField *nameTF;

@end

@implementation LHChangeLockNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"修改设备名", nil);
    [self addTextfieldViews];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"保存", nil) isLeft:NO WithBlock:^{
        [weakSelf SaveAction];
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)addTextfieldViews{
    LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10), kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
    textfiledView.backgroundColor = [UIColor backgroundColor];
    _nameTF = textfiledView.textfield;
    _nameTF.text = self.lockModel.lockName;
    textfiledView.titleLabel.text = NSLocalizedString(@"设备名", nil);
    textfiledView.textfield.placeholder = NSLocalizedString(@"请输入设备名称", nil);
    [self.view addSubview:textfiledView];
}

- (void)SaveAction{
    if ([_nameTF.text isEqualToString:@""]) {
        [self showFailed:NSLocalizedString(@"请输入设备名称", nil)];
    }else{
        __weak typeof(self)weakSelf = self;
        [[LHDeviceService sharedInstance] changeLockNameWithGatewaySN:@"" andLockSN:self.lockModel.lockSn andLockName:_nameTF.text completed:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"responseObject%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeLockNameChange object:nil];
            [weakSelf showSucceed:NSLocalizedString(@"保存成功", nil) complete:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
    }
}

//- (void)changeSuccess{
//    [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeLockNameChange object:nil];
//    [self showSucceed:NSLocalizedString(@"保存成功", nil) complete:^{
//        
//    }];
//}

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
