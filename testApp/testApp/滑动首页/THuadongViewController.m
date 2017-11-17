//
//  THuadongViewController.m
//  testApp
//
//  Created by 崔关 on 2017/11/16.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "THuadongViewController.h"
#import "THuadongTableViewCell.h"

@interface THuadongViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,assign) BOOL canScroll;

@property (nonatomic,strong) BaseUITableView *table;
@property (nonatomic,strong) THuadongTableViewCell *tcell;

@end

@implementation THuadongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPageViewCtrlChange:) name:@"CenterPageViewScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOtherScrollToTop:) name:@"kLeaveTopNtf" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScrollBottomView:) name:@"PageViewGestureState" object:nil];

    [self.view addSubview:self.table];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.showsHorizontalScrollIndicator = NO;
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.view setNeedsLayout];
}

- (THuadongTableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (!self.tcell) {
        self.tcell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [self.tcell setCustomView];
    }
    
    return self.tcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor blueColor];
    return headerView;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height - 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

///通知的处理
//pageViewController页面变动时的通知
- (void)onPageViewCtrlChange:(NSNotification *)ntf {
    //更改YUSegment选中目标

}

//子控制器到顶部了 主控制器可以滑动
- (void)onOtherScrollToTop:(NSNotification *)ntf {
    self.canScroll = YES;
    self.tcell.canScroll = NO;
}

//当滑动下面的PageView时，当前要禁止滑动
- (void)onScrollBottomView:(NSNotification *)ntf {
    if ([ntf.object isEqualToString:@"ended"]) {
        //bottomView停止滑动了  当前页可以滑动
        self.table.scrollEnabled = YES;
    } else {
        //bottomView滑动了 当前页就禁止滑动
        self.table.scrollEnabled = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //子控制器和主控制器之间的滑动状态切换
    CGFloat tabOffsetY = [self.table rectForSection:0].origin.y;
    if (scrollView.contentOffset.y >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        if (_canScroll) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kScrollToTopNtf" object:@1];
            _canScroll = NO;
            self.tcell.canScroll = YES;
        }
    } else {
        if (!_canScroll) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        }
    }
}

- (BaseUITableView *)table {
    if (!_table) {
        _table = [[BaseUITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[THuadongTableViewCell class] forCellReuseIdentifier:@"cell"];
        _table.tableHeaderView = [self headerView];
        _table.scrollsToTop = NO; //每个页面只能有一个scrollview 能设置为YES
    }
    return _table;
}

- (UIView *)headerView {
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, 300, 200);
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

@end
