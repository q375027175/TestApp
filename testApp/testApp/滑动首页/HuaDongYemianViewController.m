//
//  HuaDongYemianViewController.m
//  testApp
//
//  Created by juge on 2017/10/31.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "HuaDongYemianViewController.h"
#import "HuadongHeaderView.h"

#define SCROLLHEIGHT WINDOWHEIGHT - SCROLLY

#define SCROLLY CGRectGetMaxY(self.headerView.frame)

#define WINDOWWIDTH CGRectGetWidth(self.view.frame)

#define WINDOWHEIGHT CGRectGetHeight(self.view.frame)

@interface HuaDongYemianViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HuadongHeaderView *headerView;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UITableView *table1;
@property (nonatomic, strong) UITableView *table2;

@end

@implementation HuaDongYemianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerView = [[HuadongHeaderView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
    self.headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.headerView];
    [self.headerView layoutIfNeeded];
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), SCROLLHEIGHT)];
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 2, SCROLLHEIGHT);
    self.scroll.pagingEnabled = YES;
    self.scroll.bounces = NO;
    [self.view addSubview:self.scroll];
    
    self.table1 = [[UITableView alloc]initWithFrame:self.scroll.bounds style:(UITableViewStylePlain)];
    self.table1.delegate = self;
    self.table1.dataSource = self;
    [self.scroll addSubview:self.table1];
    
    CGRect rect = self.scroll.bounds;
    rect.origin.x += rect.size.width;
    self.table2 = [[UITableView alloc]initWithFrame:rect style:(UITableViewStylePlain)];
    self.table2.delegate = self;
    self.table2.dataSource = self;
    [self.scroll addSubview:self.table2];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
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
    if(scrollView != self.scroll) {
        CGRect headerRect = self.headerView.frame;
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat headerY = headerRect.origin.y;
        if(offsetY > 0 && headerY > -136) {
            headerRect.origin.y -= offsetY;
            if(headerRect.origin.y < - 136) {
                headerRect.origin.y = - 136;
            }
            self.headerView.frame = headerRect;
            [self refreshView];
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        if(offsetY < 0 && headerY < 0) {
            headerRect.origin.y -= offsetY;
            if(headerRect.origin.y > 0) {
                headerRect.origin.y = 0;
            }
            
            self.headerView.frame = headerRect;
            self.scroll.frame = CGRectMake(0, SCROLLY, WINDOWWIDTH, SCROLLHEIGHT);
            [self refreshView];
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        //      多张表同时滑动
        //        if(scrollView == self.table1) {
        //            self.table2.contentOffset = self.table1.contentOffset;
        //        } else if(scrollView == self.table2) {
        //            self.table1.contentOffset = self.table2.contentOffset;
        //        }
    }
}

- (void)refreshView {
    self.scroll.frame = CGRectMake(0, SCROLLY, WINDOWWIDTH, SCROLLHEIGHT);
    self.table1.frame = CGRectMake(0, 0, WINDOWWIDTH, SCROLLHEIGHT);
    self.table2.frame = CGRectMake(WINDOWWIDTH, 0, WINDOWWIDTH, SCROLLHEIGHT);;
    self.table1.contentOffset = CGPointMake(0, 0);
    self.table2.contentOffset = CGPointMake(0, 0);
}

@end

