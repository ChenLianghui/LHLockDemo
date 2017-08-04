//
//  LHAddUserViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddUserViewController.h"
#import "LHDeviceService.h"

@interface LHAddUserViewController ()

@property (nonatomic,strong)UITextField *accountTF;
@property (nonatomic,strong)UITextField *passwordTF;
@property (nonatomic,strong)UITextField *startDateTF;
@property (nonatomic,strong)UITextField *endDateTF;
@property (nonatomic,strong)UIDatePicker *startDatePicker;
@property (nonatomic,strong)UIDatePicker *endDatePicker;
@property (nonatomic,strong)UISwitch *aSwitch;
@property (nonatomic,strong)UIButton *deleteButton;

@end

@implementation LHAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    if (self.isAdd) {
        self.title = NSLocalizedString(@"添加用户", nil);
    }else{
        self.title = NSLocalizedString(@"用户详情", nil);
        [self addDeleteButton];
    }
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"保存", nil) isLeft:NO WithBlock:^{
        [weakSelf saveAction];
    }];
    // Do any additional setup after loading the view.
}

- (void)addSubviews{
    NSArray *titleArray = @[NSLocalizedString(@"授权用户", nil),NSLocalizedString(@"开锁密码", nil),NSLocalizedString(@"开始时间", nil),NSLocalizedString(@"结束时间", nil),NSLocalizedString(@"有效", nil)];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = [UIColor grayFontColor];
        titleLabel.font = [UIFont appFontThree];
        [self.view addSubview:titleLabel];
        
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kBorderMargin);
            make.top.equalTo(kHeightIphone7(20)+(kHeightIphone7(20)+kHeightIphone7(20))*i);
            make.width.equalTo(kWidthIphone7(100));
            make.height.equalTo(kHeightIphone7(20));
        }];
    }
    
    _accountTF = [UITextField new];
    _accountTF.textColor = [UIColor grayFontColor];
    _accountTF.font = [UIFont appFontThree];
    _accountTF.placeholder = NSLocalizedString(@"请输入授权用户的账号", nil);
    if (!self.isAdd) {
        _accountTF.text = self.authUserModel.username;
        _accountTF.userInteractionEnabled = NO;
    }
    [self.view addSubview:_accountTF];
    
    _passwordTF = [UITextField new];
    _passwordTF.textColor = [UIColor grayFontColor];
    _passwordTF.font = [UIFont appFontThree];
    _passwordTF.placeholder = NSLocalizedString(@"请输入开锁密码", nil);
    [self.view addSubview:_passwordTF];
    
    _startDateTF = [UITextField new];
    _startDateTF.textColor = [UIColor grayFontColor];
    _startDateTF.font = [UIFont appFontThree];
    _startDateTF.placeholder = NSLocalizedString(@"请选择开始时间", nil);
    _startDateTF.inputView = self.startDatePicker;
    if (!self.isAdd) {
        _startDateTF.text = [LHUtils timeStampSwitchDateStr:self.authUserModel.start];
    }
    [self.view addSubview:_startDateTF];
    
    _endDateTF = [UITextField new];
    _endDateTF.textColor = [UIColor grayFontColor];
    _endDateTF.font = [UIFont appFontThree];
    _endDateTF.placeholder = NSLocalizedString(@"请选择结束时间", nil);
    _endDateTF.inputView = self.endDatePicker;
    if (!self.isAdd) {
        _endDateTF.text = [LHUtils timeStampSwitchDateStr:self.authUserModel.end];
    }
    [self.view addSubview:_endDateTF];
    
    _aSwitch = [UISwitch new];
//    [_aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    if (self.isAdd) {
        [_aSwitch setOn:YES];
    }else{
        if ([self.authUserModel.status isEqualToString:@"valid"]) {
            [_aSwitch setOn:YES];
        }else{
            [_aSwitch setOn:NO];
        }
    }
    
    [self.view addSubview:_aSwitch];
    
    [_accountTF makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kHeightIphone7(20));
        make.left.equalTo(kWidthIphone7(120)+kBorderMargin);
        make.right.equalTo(-kBorderMargin);
        make.height.equalTo(kHeightIphone7(20));
    }];
    [_passwordTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTF);
        make.top.equalTo(_accountTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_startDateTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTF);
        make.top.equalTo(_passwordTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_endDateTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTF);
        make.top.equalTo(_startDateTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_aSwitch makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kBorderMargin);
        make.top.equalTo(_endDateTF.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(40));
        make.height.equalTo(kHeightIphone7(20));
    }];
}

//添加删除按钮
- (void)addDeleteButton{
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
    _deleteButton.layer.masksToBounds = YES;
    _deleteButton.layer.masksToBounds = kHeightIphone7(20);
    [_deleteButton setBackgroundColor:[UIColor redColor]];
    [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton];
    
    [_deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kScreenSize.width/6);
        make.centerX.equalTo(self.view);
        make.top.equalTo(_aSwitch.bottom).offset(kHeightIphone7(50));
        make.height.equalTo(kHeightIphone7(40));
    }];
}

- (void)deleteButtonClicked{
    __weak typeof(self)weakSelf = self;
    [[LHDeviceService sharedInstance] deleteAuthWithLockSN:self.lockModel.lockSn andAuth_user:self.authUserModel.username completed:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"resonseObject:%@",responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeAutherUserAmountChange object:nil];
        [weakSelf showSucceed:NSLocalizedString(@"删除成功", nil) complete:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

//- (void)switchChanged:(UISwitch *)aswitch{
//    
//}

- (void)saveAction{
    if ([_accountTF.text isEqualToString:@""]) {
        [self showFailed:NSLocalizedString(@"请输入授权用户的账号", nil)];
    }else if([_passwordTF.text isEqualToString:@""]){
        [self showFailed:NSLocalizedString(@"请输入开锁密码", nil)];
    }else if ([_startDateTF.text isEqualToString:@""]){
        [self showFailed:NSLocalizedString(@"请选择开始时间", nil)];
    }else if ([_endDateTF.text isEqualToString:@""]){
        [self showFailed:NSLocalizedString(@"请选择结束时间", nil)];
    }else{
        NSString *status;
        if (_aSwitch.isOn) {
            status = @"valid";
        }else{
            status = @"invalid";
        }
        __weak typeof(self)weakSelf = self;
        [[LHDeviceService sharedInstance] addNewAuthWithLockSN:self.lockModel.lockSn andAuth_user:_accountTF.text andPassword:_passwordTF.text andStartTime:_startDateTF.text andEndTime:_endDateTF.text status:status completed:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"resonseObject:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeAutherUserAmountChange object:nil];
            [weakSelf showSucceed:NSLocalizedString(@"保存成功", nil) complete:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
    }
    
}

- (void)startPickerClicked:(UIDatePicker *)datePick{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    _startDateTF.text = [dateFormatter stringFromDate:datePick.date];
}

- (void)endPickerClicked:(UIDatePicker *)datePick{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    _endDateTF.text = [dateFormatter stringFromDate:datePick.date];
}

- (UIDatePicker *)startDatePicker{
    if (!_startDatePicker) {
        _startDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _startDatePicker.datePickerMode = UIDatePickerModeDate;
        _startDatePicker.minimumDate = [NSDate date];
        [_startDatePicker addTarget:self action:@selector(startPickerClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _startDatePicker;
}

- (UIDatePicker *)endDatePicker{
    if (!_endDatePicker) {
        _endDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _endDatePicker.datePickerMode = UIDatePickerModeDate;
        _endDatePicker.minimumDate = [NSDate date];
        [_endDatePicker addTarget:self action:@selector(endPickerClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _endDatePicker;
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
