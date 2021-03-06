//
//  QHuadongViewController.m
//  testApp
//
//  Created by 崔关 on 2017/11/17.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "QHuadongViewController.h"
#import "HuadongHeaderView.h"

#define HeaderHeight 200

@interface QHuadongViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HuadongHeaderView *headerView;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UITableView *table1;
@property (nonatomic, strong) UITableView *table2;
@property (nonatomic, strong) NSArray *array;

@end

@implementation QHuadongViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scroll = [[UIScrollView alloc]init];
    self.scroll.pagingEnabled = YES;
    self.scroll.bounces = NO;
    [self.view addSubview:self.scroll];
    
    self.table1 = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.table1.delegate = self;
    self.table1.dataSource = self;
    UIEdgeInsets inset1 = self.table2.contentInset;
    inset1.top = HeaderHeight;
    self.table1.contentInset = inset1;
    
    [self.scroll addSubview:self.table1];
    
    self.table2 = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.table2.delegate = self;
    self.table2.dataSource = self;
    UIEdgeInsets inset2 = self.table2.contentInset;
    inset2.top = HeaderHeight;
    self.table2.contentInset = inset2;
    
    [self.scroll addSubview:self.table2];
    
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.table1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(@(kWIDTH));
        make.height.equalTo(self.scroll.mas_height);
    }];
    
    [self.table2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.equalTo(@(kWIDTH));
        make.left.equalTo(self.table1.mas_right);
        make.height.equalTo(self.scroll.mas_height);
    }];
    
    [self.scroll layoutIfNeeded];
    [self.table2 layoutIfNeeded];
    [self.table1 layoutIfNeeded];
    
    self.array = @[self.table1, self.table2];
    
    self.headerView = [[HuadongHeaderView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), HeaderHeight)];
    self.headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.headerView];
    [self.headerView layoutIfNeeded];
    
    [self.view bringSubviewToFront:self.headerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"CELL = %zd", indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat headerHeight = HeaderHeight;
    CGFloat maxOffset = 70;  // 最大留存量
    
    NSInteger index = self.scroll.contentOffset.x / kWIDTH;
    if(scrollView != self.array[index]) return; /// 防止移动其他tableview影响界面
    
/// 处理headerview的位置
    CGRect headerRect = self.headerView.frame;
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < -maxOffset) {
        headerRect.origin.y = -offsetY - headerHeight;
//        if(headerRect.origin.y > 0) {  // headerview禁止随着tableview下拉
//            headerRect.origin.y = 0;
//        }
        
        self.headerView.frame = headerRect;
    }
    if (offsetY >= -maxOffset) { // 当tableview 移动到最上方的时候强制写死headerview位置
        headerRect.origin.y = -(headerHeight - maxOffset);
        self.headerView.frame = headerRect;
    }
    
///  处理未显示的tableview的contentoffset   在headerview 显示出来的时候，保证所有tableview的同步
    if (offsetY > -headerHeight) {
        for (UITableView *table in self.array) {
            if (table != scrollView) {
                if (offsetY > -maxOffset && table.contentOffset.y < 0){ /// headerview移出屏幕
                    table.contentOffset = CGPointMake(0, -maxOffset);
                }
                
                if (offsetY <= -maxOffset) { // headerview开始出现在屏幕
                    table.contentOffset = CGPointMake(0, offsetY);
                }
            }
        }
    } else if (offsetY < -headerHeight) { // 超出最大偏移量的处理
        for (UITableView *table in self.array) {
            if (table != scrollView) {
                table.contentOffset = CGPointMake(0, -headerHeight);
            }
        }
    }
}

@end
