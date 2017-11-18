//
//  QKTourApplyDateMenuView.h
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QKMenuViewDelegate<NSObject>

- (void)QKMenuViewSelectButtonWithIndex:(NSInteger)index;

@end

@interface QKTourApplyDateMenuView : UIView

@property (nonatomic, weak) id<QKMenuViewDelegate> delegate;

- (void)selectMenuViewWithIndex:(NSInteger)index;

@end
