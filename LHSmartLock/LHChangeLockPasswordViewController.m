//
//  LHChangeLockPasswordViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/13.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHChangeLockPasswordViewController.h"
#import "LHBaseTextfiledView.h"
//#import "LHNumberKeyBoard.h"

@interface LHChangeLockPasswordViewController ()

@end

@implementation LHChangeLockPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"修改密码", nil);
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
        textfiledView.textfield.tag = 60+i;
        [self.view addSubview:textfiledView];
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
