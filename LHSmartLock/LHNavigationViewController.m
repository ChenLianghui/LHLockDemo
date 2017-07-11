//
//  LHNavigationViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHNavigationViewController.h"

@interface LHNavigationViewController ()

@end

@implementation LHNavigationViewController
    
+ (void)load{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor naviBackColor];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    //self.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
