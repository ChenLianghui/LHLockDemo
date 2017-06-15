//
//  LHChangeLockNameViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHChangeLockNameViewController.h"
#import "LHBaseTextfiledView.h"

@interface LHChangeLockNameViewController ()

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
    // Do any additional setup after loading the view.
}

- (void)addTextfieldViews{
    LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10), kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
    textfiledView.backgroundColor = [UIColor backgroundColor];
    textfiledView.textfield.tag = 90;
    textfiledView.titleLabel.text = NSLocalizedString(@"设备名", nil);
    textfiledView.textfield.placeholder = NSLocalizedString(@"请输入设备名称", nil);
    [self.view addSubview:textfiledView];
}

- (void)SaveAction{
    
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
