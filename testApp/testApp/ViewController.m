//
//  ViewController.m
//  testApp
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "ViewController.h"
#import "PlaceViewController.h"
#import "DouyuViewController.h"
#import "KaidengViewController.h"
#import "JiequUrlViewController.h"
#import "UITableView+NoDataView.h"
#import "JiequURLUIWebviewViewController.h"
#import "HuaDongYemianViewController.h"
#import "THuadongViewController.h"
#import "dianhuabenViewController.h"
#import "QHuadongViewController.h"
#import "CalendarViewController.h"
#import "LoginViewController.h"
#import "JianbianViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)testDelegate {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollToBack];
    self.title = @"首页";
    self.array = @[@"登陆",@"附近有啥", @"直播",@"手电筒",@"解析网页",@"解析网页UIWebView",@"scroll滑动页面", @"tableview滑动页面", @"Q滑动页面", @"电话本", @"日历",@"颜色渐变"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.showMessage = @"啥也没有";
    [self.tableView reloadData];
    
    NSDate *date = [NSDate date];
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSInteger i = 1; i <= date.daysInMonth; i ++) {
        NSDate *firstDate = [NSDate dateWithYear:date.year month:date.month day:i];
        [muArr addObject:@{@"days":@(i), @"weekday":@(firstDate.weekday)}];
    }
    
    NSInteger weekDay1 = 7 - [muArr.firstObject[@"weekday"] integerValue];
    for (NSInteger i = 0; i < weekDay1; i ++) {
        [muArr insertObject:@{} atIndex:0];
    }
    
    NSInteger weekDay2 = 7 - [muArr.lastObject[@"weekday"] integerValue];
    for (NSInteger i = 0; i < weekDay2; i ++) {
        [muArr addObject:@{}];
    }
    
    [self setStrings:@"A", @"B", @"C", @"D", @"E", @"F",
     @"G", @"H", @"I", @"J", @"Q", @"L", @"M", @"N", @"O", @"P",
     @"Q", @"I", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",
     nil];
    
    NSInteger x = 0;
    
    while ((x = x + 1) < 10) {
        NSLog(@"~~~~~~~~~~~%zd", x);
    }
    
    [self lock];
    [self lock];
}

- (void)setStrings:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION {
    CGLog(@"传多个参数的第一个参数 %@",string);//是other1

    va_list args;
    va_start(args, string);
    
    if (string) {
        NSMutableArray *muArr = [NSMutableArray arrayWithObject:string];
        NSString *str = nil;
        while ((str = va_arg(args, NSString *))) {
            if (str) {
                [muArr addObject:str];
                CGLog(@"其他: %@", str);
            }
        }
        
        CGLog(@"muArr count = %zd", muArr.count);
    }
    va_end(args);
}

- (void)lock {
    //  NSLock
    static NSLock *lock = nil;
    if (!lock) {
        lock = [[NSLock alloc] init];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        CGLog(@"----------------------");
        sleep(10);
        [lock unlock];
    });
    // @synchronized
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            CGLog(@"～～～～～～～～～～～～～");
            sleep(10);
        }
    });
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row]; //self.array[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    NSString *title = self.array[indexPath.row];
    
    if ([title isEqualToString:@"附近有啥"]) {
        vc = [[PlaceViewController alloc] init];
    } else if ([title isEqualToString:@"直播"]) {
        vc = [[DouyuViewController alloc] init];
    } else if ([title isEqualToString:@"手电筒"]) {
        vc = [[KaidengViewController alloc] init];
    } else if ([title isEqualToString:@"解析网页"]) {
        vc = [[JiequUrlViewController alloc] init];
    } else if ([title isEqualToString:@"解析网页UIWebView"]) {
        vc = [[JiequURLUIWebviewViewController alloc] init];
    } else if ([title isEqualToString:@"scroll滑动页面"]) {
        vc = [[HuaDongYemianViewController alloc] init];
    } else if ([title isEqualToString:@"tableview滑动页面"]) {
        vc = [[THuadongViewController alloc] init];
    } else if ([title isEqualToString:@"电话本"]) {
        vc = [[dianhuabenViewController alloc] init];
    } else if ([title isEqualToString:@"Q滑动页面"]) {
        vc = [[QHuadongViewController alloc] init];
    } else if ([title isEqualToString:@"日历"]) {
        vc = [[CalendarViewController alloc] init];
    } else if ([title isEqualToString:@"登陆"]) {
        vc = [[LoginViewController alloc] init];
    } else if ([title isEqualToString:@"颜色渐变"]) {
        vc = [[JianbianViewController alloc] init];
    }
    
    if (vc) {
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 44.0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end
