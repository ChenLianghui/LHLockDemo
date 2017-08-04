//
//  LHLoginViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/5.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLoginViewController.h"
#import "LHLoginView.h"
#import "LHRegistViewController.h"
#import "LHLostPassWordOneViewController.h"
#import "LHTabBarViewController.h"
#import "LHLoginService.h"
#import "JPUSHService.h"

@interface LHLoginViewController ()<LHLoginViewDelegate>

@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)LHLoginView *loginView;

@end

@implementation LHLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![LHUtils isEmptyStr:[[NSUserDefaults standardUserDefaults] valueForKey:key_currentUserName]]) {
        self.loginView.userTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:key_currentUserName];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" isLeft:YES WithBlock:nil];
    [self.view addSubview:self.bgImageView];
    [self.view insertSubview:self.mainView aboveSubview:self.bgImageView];
    [self.mainView addSubview:self.loginView];
    [self.mainView addSubview:self.iconImageView];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    //    如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}

- (void)ButtonHadClickedWithTag:(NSInteger)tag{
    switch (tag) {
        case 30:
        {
            //点击登录按钮
            NSLog(@"登录");
            __weak typeof(self)weakSelf = self;
            [[LHLoginService sharedInstance] loginWithUserName:self.loginView.userTextField.text andPassword:self.loginView.passwordTextField.text completed:^(NSURLSessionTask *task, id responseObject) {
                NSLog(@"responseObject:%@",responseObject);
                [weakSelf showSucceed:NSLocalizedString(@"登录成功", nil) complete:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakSelf.isFirstComein) {
                            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                            LHTabBarViewController *tabarVC = [[LHTabBarViewController alloc] init];
                            keyWindow.rootViewController = tabarVC;
                            [keyWindow makeKeyAndVisible];
                        }else{
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                    });
                }];
                
                [JPUSHService setAlias:weakSelf.loginView.userTextField.text callbackSelector:nil object:nil];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                
            }];
            
        }
            break;
        case 31:
        {
            //点击注册按钮
            NSLog(@"注册");
            LHRegistViewController *RegistVC = [[LHRegistViewController alloc] init];
            [self.navigationController pushViewController:RegistVC animated:YES];
        }
            break;
        case 32:
        {
            //点击忘记密码按钮
            NSLog(@"忘记密码");
            LHLostPassWordOneViewController *oneVC = [[LHLostPassWordOneViewController alloc] init];
            [self.navigationController pushViewController:oneVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (LHLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LHLoginView alloc] init];
        _loginView.center = self.view.center;
        _loginView.delegate = self;
    }
    return _loginView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
        _bgImageView.image = [UIImage imageNamed:@"loginBG"];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo"]];
        _iconImageView.frame = CGRectMake(0, 0, kWidthIphone7(100), kWidthIphone7(100));
        CGPoint center = self.view.center;
        center.y -= kHeightIphone7(90+70);
        _iconImageView.center = center;
    }
    return _iconImageView;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenSize.width, kScreenSize.height)];
        _mainView.backgroundColor = [UIColor clearColor];
    }
    return _mainView;
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
