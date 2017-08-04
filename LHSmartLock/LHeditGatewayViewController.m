//
//  LHeditGatewayViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/7/18.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHeditGatewayViewController.h"
#import "LHBaseTextfiledView.h"
#import "LHDeviceService.h"
#import "LHGatewayListViewController.h"
#import "LHGatewayDetailViewController.h"

@interface LHeditGatewayViewController ()

@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)UIButton *deleteButton;

@end

@implementation LHeditGatewayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"编辑网关", nil);
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"保存", nil) isLeft:NO WithBlock:^{
        [weakSelf saveAction];
    }];
    
    [self createSubViews];
    [self.view addSubview:self.deleteButton];
    // Do any additional setup after loading the view.
}

- (void)createSubViews{
    NSArray *titleArray = @[NSLocalizedString(@"序列号", nil),NSLocalizedString(@"名称", nil)];
    for (int i = 0; i < titleArray.count; i ++) {
        LHBaseTextfiledView *textfieldView = [[LHBaseTextfiledView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(20)+(kHeightIphone7(20)+kHeightIphone7(40))*i, kScreenSize.width, kHeightIphone7(40))];
        textfieldView.titleLabel.text = titleArray[i];
        if (i == 0) {
            textfieldView.textfield.text = self.gatewayModel.gatewaySn;
            textfieldView.textfield.userInteractionEnabled = NO;
        }else{
            _nameTF = textfieldView.textfield;
            _nameTF.text = self.gatewayModel.gatewayName;
            _nameTF.placeholder = NSLocalizedString(@"请输入网关的名称", nil);
        }
        [self.view addSubview:textfieldView];
    }
}

- (void)deleteButtonClicked{
    __weak typeof(self)weakSelf = self;
    [[LHDeviceService sharedInstance] deleteGateWayWithSN:self.gatewayModel.gatewaySn completed:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [weakSelf showSucceed:NSLocalizedString(@"删除成功", nil) complete:^{
            for (UIViewController *VC in weakSelf.navigationController.viewControllers) {
                if ([VC isKindOfClass:[LHGatewayListViewController class]]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeGatewayAmountChange object:nil];
                    [weakSelf.navigationController popToViewController:VC animated:YES];
                }
            }
        }];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

#pragma mark - 点击保存
- (void)saveAction{
    if ([_nameTF.text isEqualToString:@""]) {
        [self showFailed:NSLocalizedString(@"请输入网关的名称", nil)];
    }else if ([_nameTF.text isEqualToString:self.gatewayModel.gatewayName]){
        [self showFailed:NSLocalizedString(@"请输入新的网关名称", nil)];
    }else{
        __weak typeof(self)weakSelf = self;
        [[LHDeviceService sharedInstance] reNameGateWayWithName:_nameTF.text andSN:self.gatewayModel.gatewaySn completed:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:key_NoticeGatewayAmountChange object:nil];
            [weakSelf showSucceed:NSLocalizedString(@"保存成功", nil) complete:^{
                for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[LHGatewayDetailViewController class]]) {
                        LHGatewayDetailViewController *detailVC = (LHGatewayDetailViewController *)vc;
                        LHGatewayModel *model = weakSelf.gatewayModel;
                        model.gatewayName = _nameTF.text;
                        detailVC.gatewayModel = model;
                        [weakSelf.navigationController popToViewController:detailVC animated:YES];
                    }
                }
            }];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
    }
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(kScreenSize.width/6, kHeightIphone7(200), kScreenSize.width*2/3., kHeightIphone7(40));
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = kHeightIphone7(20);
        _deleteButton.backgroundColor = [UIColor redColor];
        [_deleteButton setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
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
