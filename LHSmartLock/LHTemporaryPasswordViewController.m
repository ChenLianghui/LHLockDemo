//
//  LHTemporaryPasswordViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/14.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHTemporaryPasswordViewController.h"

@interface LHTemporaryPasswordViewController ()

@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)UILabel *passwordLabel;
@property (nonatomic,strong)UILabel *desLabel;

@end

@implementation LHTemporaryPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"临时密码", nil);
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.desLabel];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"刷新", nil) isLeft:NO WithBlock:^{
        [weakSelf refreshPassword];
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)refreshPassword{
    NSString *strRandom = @"";
    for (int i = 0; i < 6; i++) {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random()%9)];
    }
    _passwordLabel.text = strRandom;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(10), kScreenSize.width, kHeightIphone7(40))];
        _mainView.backgroundColor = [UIColor backgroundColor];
        UILabel *temporaryLabel = [UILabel new];
        temporaryLabel.text = NSLocalizedString(@"临时密码", nil);
        temporaryLabel.font = [UIFont appFontTwo];
        temporaryLabel.textColor = [UIColor grayFontColor];
        [_mainView addSubview:temporaryLabel];
        
        _passwordLabel = [UILabel new];
        _passwordLabel.font = [UIFont appFontTwo];
        _passwordLabel.text = @"234242";
        [_mainView addSubview:_passwordLabel];
        
        UILabel *rightLabel = [UILabel new];
        rightLabel.font = [UIFont appFontTwo];
        rightLabel.textColor = [UIColor grayFontColor];
        rightLabel.text = NSLocalizedString(@"有效", nil);
        rightLabel.textAlignment = NSTextAlignmentRight;
        [_mainView addSubview:rightLabel];
        
        [temporaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kBorderMargin);
            make.width.equalTo(kWidthIphone7(70));
            make.top.equalTo(kHeightIphone7(10));
            make.height.equalTo(kHeightIphone7(20));
        }];
        
        if (![LHUtils isCurrentLanguageIsChinese]) {
            [temporaryLabel updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(kWidthIphone7(160));
            }];
        }
        
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-kBorderMargin);
            make.top.equalTo(temporaryLabel.top);
            make.width.equalTo(kWidthIphone7(50));
            make.height.equalTo(kHeightIphone7(20));
        }];
        
        [_passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(temporaryLabel.top);
            make.left.equalTo(temporaryLabel.right).offset(kWidthIphone7(10));
            make.right.equalTo(rightLabel.left).offset(-kWidthIphone7(10));
            make.height.equalTo(temporaryLabel.height);
        }];
    }
    return _mainView;
}

- (UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorderMargin, CGRectGetMaxY(self.mainView.frame), kScreenSize.width-kBorderMargin*2, kHeightIphone7(30))];
        _desLabel.text = NSLocalizedString(@"临时密码仅能使用一次，使用之后自动失效", nil);
        _desLabel.textColor = [UIColor grayFontColor];
        _desLabel.numberOfLines = 0;
        _desLabel.font = [UIFont appFontFour];
    }
    return _desLabel;
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
