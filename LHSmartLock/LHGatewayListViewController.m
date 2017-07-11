//
//  LHGatewayListViewController.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/13.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHGatewayListViewController.h"
#import "LHBaseTableViewCell.h"
#import "LHBaseTableModel.h"
#import "LHDeviceService.h"
#import "LHGatewayModel.h"

@interface LHGatewayListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LHGatewayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"网关列表", nil);
    [self.view addSubview:self.tableview];
    [self getDate];
    // Do any additional setup after loading the view.
}

- (void)getDate{
    [[LHDeviceService sharedInstance] findAllGatewayCompleted:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NSArray *dataArray = [responseObject valueForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            LHGatewayModel *model = [LHGatewayModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBaseTableViewCell"];
    if (!cell) {
        cell = [[LHBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LHBaseTableViewCell"];
    }
    cell.gatewayModel = self.dataArray[indexPath.row];
    return cell;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = kHeightIphone7(40);
        [_tableview registerClass:[LHBaseTableViewCell class] forCellReuseIdentifier:@"LHBaseTableViewCell"];
        _tableview.tableFooterView = [[UIView alloc] init];
    }
    return _tableview;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
//        for (int i = 0; i < 5; i++) {
//            LHBaseTableModel *model = [LHBaseTableModel initBaseModelWithIconName:@"manage_gateway" labelTitle:[NSString stringWithFormat:@"网关%i",i+1] rightTitle:nil isHasSwitch:NO];
//            [_dataArray addObject:model];
//        }
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
