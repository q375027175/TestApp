//
//  QKCalendarModel.h
//  QinKun
//
//  Created by 崔关 on 2017/11/17.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import <util.h>

@interface QKCalendarModel : NSObject

@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger weekDay;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,copy) NSString *price;

@end
