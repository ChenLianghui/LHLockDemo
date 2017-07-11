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

@property (nonatomic,strong)UITextField *locknameTF;
@property (nonatomic,strong)UITextField *lockSNTF;

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
    NSArray *titleArray = @[NSLocalizedString(@"门锁名称", nil),NSLocalizedString(@"门锁序列号", nil)];
    NSArray *placeholderArray = @[NSLocalizedString(@"请输入门锁名称", nil),NSLocalizedString(@"请输入门锁序列号", nil)];
    for (int i = 0; i < 2; i ++) {
        LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+(kBorderMargin*2+kHeightIphone7(20)+kHeightIphone7(10))*i, kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
        if (i == 0) {
            _locknameTF = textfiledView.textfield;
        }else{
            _lockSNTF = textfiledView.textfield;
        }
        textfiledView.backgroundColor = [UIColor backgroundColor];
        textfiledView.titleLabel.text = titleArray[i];
        textfiledView.textfield.placeholder = placeholderArray[i];
        [self.view addSubview:textfiledView];
    }
}

- (void)NextAction{
    if (![LHUtils isEmptyStr:_locknameTF.text]) {
        if (![LHUtils isEmptyStr:_lockSNTF.text]) {
            LHAddLock2ViewController *addlock2 = [[LHAddLock2ViewController alloc] init];
//            addlock2.currentGatewaySN = [[NSUserDefaults standardUserDefaults] valueForKey:key_currentGatewaySN];
            addlock2.lockname = _locknameTF.text;
            addlock2.lockSN = _lockSNTF.text;
            [self.navigationController pushViewController:addlock2 animated:YES];

        }else{
            [self showFailed:NSLocalizedString(@"锁序列号不能为空", nil)];
        }
    }else{
        [self showFailed:NSLocalizedString(@"锁名称不能为空", nil)];
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
