//
//  LHAuthorUserViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/15.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHAuthorUserViewController.h"
#import "LHAddUserViewController.h"
#import "LHDeviceService.h"
#import "LHAuthUserModel.h"

@interface LHAuthorUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHAuthorUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"授权用户", nil);
    [self.view addSubview:self.tableview];
    __weak typeof(self)weakSelf = self;
    [self addItemWithName:NSLocalizedString(@"添加", nil) isLeft:NO WithBlock:^{
        LHAddUserViewController *addVC = [[LHAddUserViewController alloc] init];
        addVC.isAdd = YES;
        addVC.lockModel = weakSelf.lockModel;
        [weakSelf.navigationController pushViewController:addVC animated:YES];
    }];
    [self getData];
    //当详情页删除授权用户时，或者添加了新的授权用户时。此时刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hadDeletedAuthorUser) name:key_NoticeAutherUserAmountChange object:nil];
}

- (void)hadDeletedAuthorUser{
    [self getData];
}

- (void)getData{
    __weak typeof(self)weakSelf = self;
    [[LHDeviceService sharedInstance] findAllAuthUserUnderTheLockWithLockSN:self.lockModel.lockSn completed:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"resonseObject:%@",responseObject);
        [weakSelf.dataArray removeAllObjects];
        
        for (NSDictionary *dict in [responseObject valueForKey:@"data"]) {
            LHAuthUserModel *authUserModel = [[LHAuthUserModel alloc] init];
            [authUserModel setValuesForKeysWithDictionary:dict];
            [weakSelf.dataArray addObject:authUserModel];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    LHAuthUserModel *authUserModel = self.dataArray[indexPath.row];
    cell.textLabel.text = authUserModel.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LHAddUserViewController *detailVC = [[LHAddUserViewController alloc] init];
    detailVC.authUserModel = self.dataArray[indexPath.row];
    detailVC.isAdd = NO;
    detailVC.lockModel = self.lockModel;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = kHeightIphone7(40);
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
