//
//  LHTabBarViewController.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHTabBarViewController.h"
#import "LHHomeViewController.h"
#import "LHManageViewController.h"
#import "LHMineViewController.h"
#import "LHNavigationViewController.h"

@interface LHTabBarViewController ()

@end

@implementation LHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbarStyle];
    [self initSubViewControllers];
    // Do any additional setup after loading the view.
}
    
- (void)initSubViewControllers{
    LHHomeViewController *HomeVC = [[LHHomeViewController alloc] init];
    HomeVC.title = NSLocalizedString(@"首页", nil);
    HomeVC.tabBarItem.title = NSLocalizedString(@"首页", nil);
    HomeVC.tabBarItem.image = [UIImage imageNamed:@"main"];
    HomeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"main_selected"];
    LHNavigationViewController *HomeNAV = [[LHNavigationViewController alloc] initWithRootViewController:HomeVC];
    
    LHManageViewController *manageVC = [[LHManageViewController alloc] init];
    manageVC.title = NSLocalizedString(@"管理", nil);
    manageVC.tabBarItem.title = NSLocalizedString(@"管理", nil);
    manageVC.tabBarItem.image = [UIImage imageNamed:@"set"];
    manageVC.tabBarItem.selectedImage = [UIImage imageNamed:@"set_selected"];
    LHNavigationViewController *manageNAV = [[LHNavigationViewController alloc] initWithRootViewController:manageVC];
    
    LHMineViewController *mineVC = [[LHMineViewController alloc] init];
    mineVC.title = NSLocalizedString(@"我的", nil);
    mineVC.tabBarItem.title = NSLocalizedString(@"我的", nil);
    mineVC.tabBarItem.image = [UIImage imageNamed:@"mine"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_selected"];
    LHNavigationViewController *mineNAV = [[LHNavigationViewController alloc] initWithRootViewController:mineVC];
    
    self.viewControllers = @[HomeNAV,manageNAV,mineNAV];
}
    
- (void)initTabbarStyle{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor appThemeColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    self.tabBar.tintColor = [UIColor appThemeColor];
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
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
