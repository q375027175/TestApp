//
//  TestNoDataView.m
//  testApp
//
//  Created by 崔关 on 2017/11/30.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "TestNoDataView.h"

#define defaultNoDataMessage @"暂无数据"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
@interface TestNoDataView()
@property (nonatomic, strong) UILabel *noDataLabel;
@end

@implementation TestNoDataView

- (instancetype) init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.noDataLabel = [[UILabel alloc] init];
        self.noDataLabel.text = defaultNoDataMessage;
        self.noDataLabel.textColor = [UIColor grayColor];
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.noDataLabel];
        
        self.noDataLabel.bounds = CGRectMake(0, 0, 200, 30);
        
        self.noDataLabel.center = CGPointMake(kWIDTH / 2, 40);
    }
    return self;
}

- (void)setShowMessage:(NSString *)showMessage {
    self.noDataLabel.text = showMessage?:defaultNoDataMessage;
}

@end
