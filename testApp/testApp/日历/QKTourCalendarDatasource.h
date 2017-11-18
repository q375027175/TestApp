//
//  QKTourCalendarDatasource.h
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QKTourCalendarDelegate<NSObject>
@optional
- (void)tourCalendarSelectWithIndexPath:(NSIndexPath *)indexPath model:(id)model;

@end


@interface QKTourCalendarDatasource : NSObject<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) id<QKTourCalendarDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArr;
@end
