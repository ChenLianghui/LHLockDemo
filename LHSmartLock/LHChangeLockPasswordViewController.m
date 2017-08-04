//
//  LHChangeLockPasswordViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/13.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHChangeLockPasswordViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHDeviceService.h"

@interface LHChangeLockPasswordViewController ()

@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextField *textfield3;

@end

@implementation LHChangeLockPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"修改密码", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"确定", nil) isLeft:NO WithBlock:^{
        [weakSelf commitAction];
    }];
    _textfield1 = [UITextField new];
    _textfield2 = [UITextField new];
    _textfield3 = [UITextField new];
    [self createTextFiledViews];
    // Do any additional setup after loading the view.
}

- (void)createTextFiledViews{
    NSArray *titleArray = @[NSLocalizedString(@"原密码", nil),NSLocalizedString(@"新密码", nil),NSLocalizedString(@"确认新密码", nil)];
    NSArray *placeholderArray = @[NSLocalizedString(@"请输入原密码", nil),NSLocalizedString(@"请输入新密码", nil),NSLocalizedString(@"请确认新密码", nil)];
    for (int i = 0; i < titleArray.count; i++) {
        LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(20)+kHeightIphone7(60)*i, kScreenSize.width, kHeightIphone7(40))];
        textfiledView.titleLabel.text = titleArray[i];
        textfiledView.textfield.placeholder = placeholderArray[i];
        textfiledView.textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfiledView.textfield.secureTextEntry = YES;
        if (i == 0) {
            _textfield1 = textfiledView.textfield;
        }
        if (i == 1) {
            _textfield2 = textfiledView.textfield;
        }
        if (i == 2) {
            _textfield3 = textfiledView.textfield;
        }
        [self.view addSubview:textfiledView];
    }
}

- (void)commitAction{
    
    if (![LHUtils isEmptyStr:_textfield1.text]) {
        if (![LHUtils isEmptyStr:_textfield2.text]) {
            if (![LHUtils isEmptyStr:_textfield3.text]) {
                if ([_textfield2.text isEqualToString:_textfield3.text]) {
                    __weak typeof(self)weakSelf = self;
                    [[LHDeviceService sharedInstance] changeLockPasswordWithGatewaySN:@"" andLockSN:weakSelf.lockModel.lockSn andOldPassword:_textfield1.text andNewPassword:_textfield2.text completed:^(NSURLSessionTask *task, id responseObject) {
                        [weakSelf showSucceed:NSLocalizedString(@"修改密码成功", nil) complete:^{
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }];
                    } failure:^(NSURLSessionTask *operation, NSError *error) {
                        
                    }];
                }else{
                    [self showFailed:NSLocalizedString(@"两次密码输入不一致", nil)];
                }
            } else {
                [self showFailed:NSLocalizedString(@"请确认新密码", nil)];
            }
        }else{
            [self showFailed:NSLocalizedString(@"请输入新密码", nil)];
        }
    }else{
        [self showFailed:NSLocalizedString(@"请输入原密码", nil)];
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
