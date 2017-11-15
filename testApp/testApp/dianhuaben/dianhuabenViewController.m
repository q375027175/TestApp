
//
//  dianhuabenViewController.m
//  testApp
//
//  Created by juge on 2017/10/31.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "dianhuabenViewController.h"
#import "dianhuabenManager.h"
#import "BaseTableViewDataSource.h"

@interface dianhuabenViewController ()
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) BaseTableViewDataSource *tableViewDataSource;
@end

@implementation dianhuabenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    dianhuabenManager *manger = [dianhuabenManager shareManager];
    [manger getDianhuabenContentiOS8WithBlock:^(NSArray *addressArr) {
        self.tableViewDataSource.dataArr = addressArr;
        [self.table reloadData];
    }];
}

- (UITableView *)table {
    if (!_table) {
        _table = [[BaseUITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _table.delegate = self.tableViewDataSource;
        _table.dataSource = self.tableViewDataSource;
        _table.sectionIndexBackgroundColor = [UIColor clearColor];
        _table.sectionIndexColor = [UIColor blackColor];
    }
    return _table;
}

- (BaseTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[BaseTableViewDataSource alloc] init];
    }
    return _tableViewDataSource;
}

@end
