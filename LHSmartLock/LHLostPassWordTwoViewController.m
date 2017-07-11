//
//  LHLostPassWordTwoViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/6.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLostPassWordTwoViewController.h"
#import "UIButton+CountDown.h"
#import "JXTAlertManagerHeader.h"

@interface LHLostPassWordTwoViewController ()<UITextFieldDelegate>

@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *placeholderArray;

@end

@implementation LHLostPassWordTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"忘记密码", nil);
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"注册", nil) isLeft:NO WithBlock:^{
        [weakSelf nextClicked];
    }];
    [self createSubViews];
    // Do any additional setup after loading the view.
}

- (void)createSubViews{
    for (int i = 0; i < self.titleArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+(kHeightIphone7(10)+kHeightIphone7(40))*i, kScreenSize.width, kHeightIphone7(40))];
        view.backgroundColor = [UIColor grayLineColor];
        [self.view addSubview:view];
        UILabel *label = [UILabel new];
        label.text = self.titleArray[i];
        label.font = [UIFont appFontThree];
        [view addSubview:label];
        
        UITextField *inputTF = [UITextField new];
        inputTF.placeholder = self.placeholderArray[i];
        inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        inputTF.tag = 70+i;
        inputTF.secureTextEntry = YES;
//        inputTF.delegate = self;
        inputTF.font = [UIFont appFontThree];
        inputTF.keyboardType = UIKeyboardTypeNumberPad;
//        inputTF.autocorrectionType = UITextAutocorrectionTypeNo;
        [view addSubview:inputTF];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kContentMargin);
            make.top.equalTo(kHeightIphone7(10));
            make.height.equalTo(kHeightIphone7(20));
            make.width.equalTo(kWidthIphone7(100));
        }];
        
        [inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.right).offset(kWidthIphone7(5));
            make.top.equalTo(label.top);
            make.right.equalTo(view.right).offset(-kContentMargin-kWidthIphone7(100));
            make.height.equalTo(label.height);
        }];
    }
}

#pragma mark - 点击保存

- (void)nextClicked{
    for (int i = 0; i < self.titleArray.count; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:70+i];
        if ([LHUtils isEmptyStr:textField.text]) {
            switch (i) {
                case 0:
                    [self showMessage:NSLocalizedString(@"请输入新密码", nil)];
                    break;
                case 1:
                    [self showMessage:NSLocalizedString(@"请确认密码", nil)];
                    break;
                default:
                    break;
            }
            return;
        }
    }
    UITextField *textField = [self.view viewWithTag:70];
    UITextField *passWordTF = [self.view viewWithTag:71];
    if (![textField.text isEqualToString:passWordTF.text]) {
        [self showFailed:NSLocalizedString(@"两次密码输入不一致", nil)];
        return;
    }
    [self showLoadingWithMessage:NSLocalizedString(@"注册成功，正在登录~", nil)];
}

//#pragma mark - UITextfieldDelegate
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    UITextField *passWordTF = (UITextField *)[self.view viewWithTag:(textField.tag == 70 ? 71 : 70)];
//    if ([textField.text isEqualToString:@""]||[passWordTF.text isEqualToString:@""]) {
//        return;
//    }
//    if (![textField.text isEqualToString:passWordTF.text]) {
//        [self showFailed:NSLocalizedString(@"两次密码输入不一致", nil)];
//    }
//}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:NSLocalizedString(@"新密码", nil),NSLocalizedString(@"确认新密码", nil), nil];
    }
    return _titleArray;
}

- (NSArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [NSArray arrayWithObjects:NSLocalizedString(@"请输入新密码", nil),NSLocalizedString(@"请确认新密码", nil), nil];
    }
    return _placeholderArray;
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
