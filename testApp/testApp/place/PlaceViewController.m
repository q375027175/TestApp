//
//  PlaceViewController.m
//  testApp
//
//  Created by juge on 2017/10/28.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "PlaceViewController.h"

#import "TYPlaceManager.h"
#import <TencentLBS/TencentLBSLocation.h>

@interface PlaceViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation PlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self refreshData];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0,0,44,44);
    button.contentMode = UIViewContentModeScaleToFill;
    [button addTarget:self action:@selector(refreshData) forControlEvents:(UIControlEventTouchUpInside)];
    [button sizeToFit];   // 解决iOS10 NavigationItem不显示问题
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    rightItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)refreshData {
    [TYPlaceManager getPlaceArrayWithResponse:^(TencentLBSLocation *response) {
        TencentLBSPoi *poi = [[TencentLBSPoi alloc] init];
        poi.name = [NSString stringWithFormat:@"我现在在:%@", response.name?:@""];
        poi.address = response.address;
        NSMutableArray *muArr = [NSMutableArray array];
        [muArr addObject:poi];
        [muArr addObjectsFromArray:response.poiList];
        self.array = muArr;
        [self.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    TencentLBSPoi *poi = self.array[indexPath.row];
    cell.textLabel.text = poi.name?:@"";
    cell.detailTextLabel.text = poi.address?:@"";
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end

