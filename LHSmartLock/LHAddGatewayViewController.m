//
//  LHAddGatewayViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAddGatewayViewController.h"
#import "LHBaseTextfiledView.h"

@interface LHAddGatewayViewController ()

//@property (nonatomic,strong)LHBaseTextfiledView *textfiledView;

@end

@implementation LHAddGatewayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"添加网关", nil);
    [self addTextfiledViews];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"下一步", nil) isLeft:NO WithBlock:^{
        [weakSelf NextAction];
    }];
    // Do any additional setup after loading the view.
}

- (void)addTextfiledViews{
    NSArray *array1 = @[@"SSID",NSLocalizedString(@"密码", nil)];
    NSArray *array2 = @[NSLocalizedString(@"请输入SSID名称", nil),NSLocalizedString(@"请输入SSID密码", nil)];
    for (int i = 0; i< array1.count; i++) {
        LHBaseTextfiledView *textfiledView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10)+(kBorderMargin*2+kHeightIphone7(20)+kHeightIphone7(10))*i, kScreenSize.width, kBorderMargin*2+kHeightIphone7(20))];
        textfiledView.backgroundColor = [UIColor backgroundColor];
        textfiledView.titleLabel.text = array1[i];
        textfiledView.textfield.tag = 70+i;
        textfiledView.textfield.placeholder = array2[i];
        [self.view addSubview:textfiledView];
    }
}

- (void)NextAction{
    UITextField *textfield1 = (UITextField *)[self.view viewWithTag:70];
    UITextField *textfield2 = (UITextField *)[self.view viewWithTag:71];
    NSLog(@"%@",textfield1.text);
    NSLog(@"%@",textfield2.text);
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
