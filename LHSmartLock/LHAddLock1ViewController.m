//
//  LHAddLock1ViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddLock1ViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHAddLock2ViewController.h"

@interface LHAddLock1ViewController ()

@end

@implementation LHAddLock1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"添加设备", nil);
    [self addTextfieldViews];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"下一步", nil) isLeft:NO WithBlock:^{
        [weakSelf NextAction];
    }];
    // Do any additional setup after loading the view.
}

- (void)addTextfieldViews{
    LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10), kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
    textfiledView.backgroundColor = [UIColor backgroundColor];
    textfiledView.textfield.tag = 80;
    textfiledView.titleLabel.text = NSLocalizedString(@"添加门锁", nil);
    textfiledView.textfield.placeholder = NSLocalizedString(@"请输入设备名称", nil);
    [self.view addSubview:textfiledView];
}

- (void)NextAction{
    UITextField *textfield = (UITextField *)[self.view viewWithTag:80];
    LHAddLock2ViewController *addlock2 = [[LHAddLock2ViewController alloc] init];
    [self.navigationController pushViewController:addlock2 animated:YES];
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
