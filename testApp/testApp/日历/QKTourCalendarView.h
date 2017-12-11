//
//  QKTourCalendarView.h
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKTourCalendarDatasource.h"

@interface QKTourCalendarView : UIView

@property (nonatomic,weak) id<QKTourCalendarDelegate> delegate;

- (void)refreshCollectionWithYear:(NSInteger)year month:(NSInteger)month;
- (CGFloat)getHeight;
@end
