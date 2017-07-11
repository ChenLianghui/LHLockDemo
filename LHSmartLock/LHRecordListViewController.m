//
//  LHRecordListViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/12.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHRecordListViewController.h"
#import "LHRecordListTableViewCell.h"
#import "LHRecordModel.h"
#import "LHRecordCellModel.h"
#import "LHDeviceService.h"

@interface LHRecordListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"操作记录", nil);
    [self getData];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}

- (void)getData{
    [[LHDeviceService sharedInstance] getNewsWithIsPush:NO location:0 completed:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"responseObject1:%@",responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LHRecordModel *model = self.dataArray[section];
    return model.cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHRecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHRecordListTableViewCell"];
    if (!cell) {
        cell = [[LHRecordListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LHRecordListTableViewCell"];
    }
    LHRecordModel *model = self.dataArray[indexPath.section];
    LHRecordCellModel *cellModel = model.cellModels[indexPath.row];
    cell.recordModel = cellModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(20))];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorderMargin, 0, 100, kHeightIphone7(20))];
    LHRecordModel *model = self.dataArray[section];
    dateLabel.text = model.dateStr;
    [view addSubview:dateLabel];
    return view;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = kHeightIphone7(40);
        _tableview.sectionHeaderHeight = kHeightIphone7(20);
        [_tableview registerClass:[LHRecordListTableViewCell class] forCellReuseIdentifier:@"LHRecordListTableViewCell"];
    }
    return _tableview;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            LHRecordModel *recordModel = [[LHRecordModel alloc] init];
            recordModel.dateStr = @"2017-06-12";
            NSMutableArray *array = [NSMutableArray array];
            for (int j = 0; j < 3; j++) {
                LHRecordCellModel *cellModel = [[LHRecordCellModel alloc] init];
                cellModel.titleStr = [NSString stringWithFormat:@"房间%i",j+1];
                cellModel.timeStr = @"08:15-08:21";
                [array addObject:cellModel];
            }
            recordModel.cellModels = array;
            [_dataArray addObject:recordModel];
        }
    }
    return _dataArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = kHeightIphone7(20);
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
