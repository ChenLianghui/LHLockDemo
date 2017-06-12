//
//  LHLostPassWordBaseViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/6.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLostPassWordOneViewController.h"

@interface LHLostPassWordOneViewController ()

@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *placeholderArray;

@end

@implementation LHLostPassWordOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"忘记密码", nil);
    // Do any additional setup after loading the view.
}

- (void)setTitleArray:(NSArray *)titleArray{
    
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
