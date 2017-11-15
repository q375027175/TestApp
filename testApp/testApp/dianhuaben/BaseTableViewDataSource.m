//
//  BaseTableViewDataSource.m
//  testApp
//
//  Created by juge on 2017/10/31.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "BaseTableViewDataSource.h"
#import "dianhuabenModel.h"
#import "dianhuabenSectionModel.h"

@interface BaseTableViewDataSource()
@property (nonatomic, strong) NSArray *letterArr;
@end

@implementation BaseTableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    dianhuabenSectionModel *sectionModel = self.dataArr[indexPath.section];

    dianhuabenModel *model = sectionModel.contentArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = (model.mobileArr.count >= 1)?model.mobileArr.firstObject:@"";
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.letterArr;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    dianhuabenSectionModel *model = self.dataArr[section];
    return model.contentArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    dianhuabenSectionModel *model = self.dataArr[section];
    
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:12];
    title.text = model.title?:@"";
    [headerView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor grayColor];
    [headerView addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.height.equalTo(@.5);
        make.left.equalTo(@15);
    }];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor grayColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setDataArr:(NSArray *)dataArr {
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
        NSMutableArray *muArr = [NSMutableArray array];
        for (dianhuabenSectionModel *sectionModel in _dataArr) {
            [muArr addObject:sectionModel.title];
        }
        self.letterArr = [muArr copy];
    }
}

@end
