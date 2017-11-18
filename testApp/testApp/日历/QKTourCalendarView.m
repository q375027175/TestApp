//
//  QKTourCalendarView.m
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import "QKTourCalendarView.h"
#import "QKTourCalendarDatasource.h"
#import "QKTourCalendarCollectionViewCell.h"
#import "QKCalendarModel.h"

@interface QKTourCalendarView ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) QKTourCalendarDatasource *datasource;
@property (nonatomic, strong) QKCalendarModel *todayModel;
@end

@implementation QKTourCalendarView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *arr = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        
        UILabel *lastLabel = nil;
        for(NSString *title in arr) {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor whiteColor];
            label.text = title;
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.height.equalTo(@30);
                if (!lastLabel) {
                    make.left.equalTo(@0);
                } else {
                    make.left.equalTo(lastLabel.mas_right);
                    make.width.equalTo(lastLabel);
                }
                if (title == arr.lastObject) {
                    make.right.equalTo(@0);
                }
            }];
            lastLabel = label;
        }
        
        [self addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(@31);
        }];
        
        
    }
    return self;
}

- (void)refreshCollectionWithYear:(NSInteger)year month:(NSInteger)month {
    if (month > 12) {
        month = month - 12;
        year ++;
    }
    NSMutableArray *muArr = [NSMutableArray array];
    NSDate *firstDate = [NSDate dateWithYear:year month:month day:1];

    for (NSInteger i = 1; i <= firstDate.daysInMonth; i ++) {
        NSDate *obj = [NSDate dateWithYear:year month:month day:i];
        QKCalendarModel *model = [[QKCalendarModel alloc] init];
        model.day = obj.day;
        model.weekDay = obj.weekday;
        model.year = obj.year;
        model.month = obj.month;
        model.date = obj;
        model.price = @"¥999";
        if ([model.date isSameDay:[NSDate date]]) {
            self.todayModel = model;
        }
        [muArr addObject:model];
    }
    
    QKCalendarModel *firstModel = muArr.firstObject;
    NSInteger weekDay1 = firstModel.weekDay - 1;
    for (NSInteger i = 0; i < weekDay1; i ++) {
        [muArr insertObject:@"" atIndex:0];
    }
    
    QKCalendarModel *lastModel = muArr.lastObject;
    NSInteger weekDay2 = 7 - lastModel.weekDay;
    for (NSInteger i = 0; i < weekDay2; i ++) {
        [muArr addObject:@""];
    }
    
    self.datasource.dataArr = muArr;
    [self.collectionView reloadData];
}

- (CGFloat)getHeight {
    CGFloat height = (kWIDTH - 6) / 7;
    return self.datasource.dataArr.count / 7 * height + 31;
}

- (void)selectToday {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger index = [self.datasource.dataArr indexOfObject:self.todayModel];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];

        [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:(UICollectionViewScrollPositionNone)];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tourCalendarSelectWithIndexPath:model:)]) {
            [self.delegate tourCalendarSelectWithIndexPath:indexPath model:self.datasource.dataArr[indexPath.item]];
        }
    });
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self.datasource;
        _collectionView.dataSource = self.datasource;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[QKTourCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (QKTourCalendarDatasource *)datasource {
    if (!_datasource) {
        _datasource = [[QKTourCalendarDatasource alloc] init];
    }
    return _datasource;
}

- (void)setDelegate:(id<QKTourCalendarDelegate>)delegate {
    if (_delegate == delegate) return;
    _delegate = delegate;
    self.datasource.delegate = delegate;
}

@end
