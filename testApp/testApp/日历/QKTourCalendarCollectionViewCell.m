//
//  QKTourCalendarCollectionViewCell.m
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import "QKTourCalendarCollectionViewCell.h"
#import "QKCalendarModel.h"

@interface QKTourCalendarCollectionViewCell()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QKCalendarModel *calendarModel;
@property (nonatomic, strong) UILabel *price;
@end

@implementation QKTourCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = [UIColor redColor];
        self.selectedBackgroundView = selectedView;
        [self.contentView addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
        }];
        
        [self.contentView addSubview:self.price];
        
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(self.title.mas_bottom).offset(2);
            make.bottom.equalTo(@-2);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    if ([self.calendarModel isKindOfClass:[NSString class]]) {
        return;
    }
    [super setSelected:selected];
    if (selected) {
        self.title.textColor = [UIColor whiteColor];
        self.price.textColor = [UIColor whiteColor];
    } else {
        self.title.textColor = [UIColor blackColor];
        self.price.textColor = [UIColor redColor];
    }
}

- (void)setModel:(QKCalendarModel *)model {
    self.calendarModel = model;
    if ([model isKindOfClass:[NSString class]]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.title.text = @"";
        self.userInteractionEnabled = NO;
        self.price.text = @"";
        return;
    }
    self.title.text = [NSString stringWithFormat:@"%zd", model.day];
    NSDate *date = [NSDate date];
    if ([model.date isSameDay:date]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.price.text = model.price;
    } else if ([model.date isEarlierThan:date]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = NO;
        self.price.text = @"";
    } else if ([model.date isLaterThanOrEqualTo:date]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.price.text = model.price;
    }
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.adjustsFontSizeToFitWidth = YES;
        _price.textColor = [UIColor redColor];
    }
    return _price;
}

@end
