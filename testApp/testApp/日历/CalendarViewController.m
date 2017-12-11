//
//  CalendarViewController.m
//  testApp
//
//  Created by 崔关 on 2017/11/18.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "CalendarViewController.h"
#import "QKTourCalendarView.h"
#import "QKTourApplyDateMenuView.h"

@interface CalendarViewController () <QKMenuViewDelegate, QKTourCalendarDelegate>
@property (nonatomic, strong) QKTourCalendarView *calendarView;
@property (nonatomic, strong) QKTourApplyDateMenuView *menuView;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(kWIDTH));
        make.height.equalTo(@40);
    }];
    
    [self.view addSubview:self.calendarView];
    [self refreshCalendarView];
}

- (void)tourCalendarSelectWithIndexPath:(NSIndexPath *)indexPath model:(id)model {
    
}

#pragma mark 刷新日历
- (void)refreshCalendarView {
    NSDate *date = [NSDate date];
    [self.calendarView refreshCollectionWithYear:date.year month:date.month];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(1);
        make.left.equalTo(@0);
        make.width.equalTo(@(kWIDTH));
        make.height.equalTo(@([self.calendarView getHeight] + 2));
    }];
}

- (void)QKMenuViewSelectButtonWithIndex:(NSInteger)index {
    NSDate *date = [NSDate date];
    NSInteger year = date.year;
    NSInteger month = date.month + index;
    if (month > 12) {
        year ++;
        month = month - 12;
    }
    [self.calendarView refreshCollectionWithYear:year month:month];
    
    [self.calendarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([self.calendarView getHeight] + 2));
    }];
}

- (QKTourCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[QKTourCalendarView alloc] init];
        _calendarView.delegate = self;
    }
    return _calendarView;
}

- (QKTourApplyDateMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[QKTourApplyDateMenuView alloc] init];
        _menuView.delegate = self;
    }
    return _menuView;
}

@end
