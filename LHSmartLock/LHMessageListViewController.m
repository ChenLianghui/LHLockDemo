//
//  LHMessageListViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHMessageListViewController.h"
#import "LHMessageTableViewCell.h"
#import "LHMessageModel.h"

@interface LHMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"消息提醒", nil);
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMessageTableViewCell"];
    if (!cell) {
        cell = [[LHMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LHMessageTableViewCell"];
    }
    LHMessageModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kHeightIphone7(70);
        [_tableView registerClass:[LHMessageTableViewCell class] forCellReuseIdentifier:@"LHMessageTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 20; i ++) {
            LHMessageModel *model = [[LHMessageModel alloc] init];
            model.isWarning = (i+1)%2==1? YES:NO;
            model.titleStr = @"开锁";
            model.detailStr = @"1001室密码锁已开启超过20分钟。";
            model.timeStr = @"9:15 AM";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
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
