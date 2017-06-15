//
//  LHAddUserViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddUserViewController.h"
#import "LHBaseTextfiledView.h"

@interface LHAddUserViewController ()

@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextField *textfield3;

@end

@implementation LHAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"添加用户", nil);
    _textfield1 = [UITextField new];
    _textfield2 = [UITextField new];
    _textfield3 = [UITextField new];
    [self addTextFiledViews];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"保存", nil) isLeft:NO WithBlock:^{
        [weakSelf saveAction];
    }];
    // Do any additional setup after loading the view.
}

- (void)addTextFiledViews{
    NSArray *titleArray = @[NSLocalizedString(@"账户名称", nil),NSLocalizedString(@"密码", nil),NSLocalizedString(@"确认密码", nil)];
    NSArray *placeholderArray = @[NSLocalizedString(@"请输入账户名称", nil),NSLocalizedString(@"请输入密码", nil),NSLocalizedString(@"请确认密码", nil)];
    for (int i = 0; i < titleArray.count; i++) {
        LHBaseTextfiledView *textfieldView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+kHeightIphone7(50)*i, kScreenSize.width, kHeightIphone7(40))];
        switch (i) {
            case 0:
                _textfield1 = textfieldView.textfield;
                break;
            case 1:
                _textfield2 = textfieldView.textfield;
                _textfield2.keyboardType = UIKeyboardTypeNumberPad;
                break;
            case 2:
                _textfield3 = textfieldView.textfield;
                _textfield3.keyboardType = UIKeyboardTypeNumberPad;
                break;
            default:
                break;
        }
        textfieldView.titleLabel.text = titleArray[i];

        textfieldView.textfield.placeholder = placeholderArray[i];
        [self.view addSubview:textfieldView];
    }
}

- (void)saveAction{
    if (![LHUtils isEmptyStr:_textfield1.text]) {
        if (![LHUtils isEmptyStr:_textfield2.text]) {
            if (![LHUtils isEmptyStr:_textfield3.text]) {
                if ([_textfield2.text isEqualToString:_textfield3.text]) {
                    [self showSucceed:NSLocalizedString(@"保存成功", nil) complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    [self showFailed:NSLocalizedString(@"两次密码输入不一致", nil)];
                }
            } else {
                [self showFailed:NSLocalizedString(@"请确认密码", nil)];
            }
        }else{
            [self showFailed:NSLocalizedString(@"请输入密码", nil)];
        }
    }else{
        [self showFailed:NSLocalizedString(@"请输入账户名称", nil)];
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
