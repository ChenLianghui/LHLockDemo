//
//  ZQRegistViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/5.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHRegistViewController.h"
#import "UIButton+CountDown.h"

@interface LHRegistViewController ()<UITextFieldDelegate>

@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *placeholderArray;
@property (nonatomic,strong)UIButton *commitButton;

@end

@implementation LHRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"注册账号", nil);
    [self createSubViews];
    [self.view addSubview:self.commitButton];
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
        inputTF.delegate = self;
        inputTF.tag = 40+i;
        inputTF.font = [UIFont appFontThree];
        if (i == 1 || i == 2) {
            inputTF.secureTextEntry = YES;
        }
        if (i == 3 || i == 4) {
            inputTF.keyboardType = UIKeyboardTypeNumberPad;
        }
        inputTF.autocorrectionType = UITextAutocorrectionTypeNo;
        [view addSubview:inputTF];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kContentMargin);
            make.top.equalTo(kHeightIphone7(10));
            make.height.equalTo(kHeightIphone7(20));
            make.width.equalTo(kWidthIphone7(100));
        }];
        //判断当前语言是否为中文，中文的话更新约束
        if ([LHUtils isCurrentLanguageIsChinese]) {
            [label updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(kWidthIphone7(60));
            }];
        }
        
        [inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.right).offset(kWidthIphone7(5));
            make.top.equalTo(label.top);
            make.right.equalTo(view.right).offset(-kContentMargin-kWidthIphone7(100));
            make.height.equalTo(label.height);
        }];
        
        if (i == self.titleArray.count-1) {
            UIButton *verificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [verificationButton setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
            [verificationButton setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
            [verificationButton addTarget:self action:@selector(verificationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//            verificationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            verificationButton.titleLabel.font = [UIFont appFontThree];
            [view addSubview:verificationButton];
            
            [verificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(kHeightIphone7(10));
                make.right.equalTo(-kContentMargin);
                make.width.equalTo(kWidthIphone7(100));
                make.height.equalTo(kHeightIphone7(20));
            }];
        }
    }
}

- (void)verificationButtonClicked:(UIButton *)button{
    UITextField *mobileTF = (UITextField *)[self.view viewWithTag:43];
    if ([LHUtils isEmptyStr:mobileTF.text]) {
        [self showMessage:NSLocalizedString(@"请输入手机号", nil)];
        return;
    }
    [button countDownFromTime:10 title:NSLocalizedString(@"重新获取", nil) unitTitle:@"s" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    //以下为获取验证码代码
}

#pragma mark - 点击确认按钮

- (void)CommitButtonClicked:(UIButton *)button{
    for (int i = 0; i < self.titleArray.count; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:40+i];
        if ([LHUtils isEmptyStr:textField.text]) {
            switch (i) {
                case 0:
                    [self showMessage:NSLocalizedString(@"请输入用户名", nil)];
                    break;
                case 1:
                    [self showMessage:NSLocalizedString(@"请输入密码", nil)];
                    break;
                case 2:
                    [self showMessage:NSLocalizedString(@"请确认密码", nil)];
                    break;
                case 3:
                    [self showMessage:NSLocalizedString(@"请输入手机号", nil)];
                    break;
                case 4:
                    [self showMessage:NSLocalizedString(@"请输入验证码", nil)];
                    break;
                default:
                    break;
            }
            return;
        }
    }
}

#pragma mark - UITextfieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 41 || textField.tag == 42) {
        UITextField *passWordTF = (UITextField *)[self.view viewWithTag:(textField.tag == 41 ? 42 : 41)];
        if ([textField.text isEqualToString:@""]||[passWordTF.text isEqualToString:@""]) {
            return;
        }
        if (![textField.text isEqualToString:passWordTF.text]) {
            [self showFailed:NSLocalizedString(@"两次密码输入不一致", nil)];
        }
    }
}

- (UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(kWidthIphone7(40), self.titleArray.count*(kHeightIphone7(50)+20), kScreenSize.width-2*kWidthIphone7(40), kHeightIphone7(40));
        [_commitButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        _commitButton.layer.masksToBounds = YES;
        _commitButton.layer.cornerRadius = kHeightIphone7(20);
        [_commitButton setBackgroundColor:[UIColor appThemeColor]];
        [_commitButton addTarget:self action:@selector(CommitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] initWithObjects:NSLocalizedString(@"用户名", nil),NSLocalizedString(@"密码", nil),NSLocalizedString(@"确认密码", nil),NSLocalizedString(@"手机号", nil),NSLocalizedString(@"验证码", nil), nil];
    }
    return _titleArray;
}

- (NSArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [[NSArray alloc] initWithObjects:NSLocalizedString(@
                                                                               "请输入用户名", nil),NSLocalizedString(@"请输入密码", nil),NSLocalizedString(@"请确认密码", nil),NSLocalizedString(@"请输入手机号", nil),NSLocalizedString(@"请输入验证码", nil), nil];
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
