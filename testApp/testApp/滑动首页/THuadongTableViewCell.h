//
//  THuadongTableViewCell.h
//  testApp
//
//  Created by 崔关 on 2017/11/16.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THuadongTableViewCell : UITableViewCell

@property (nonatomic,assign) BOOL canScroll;

- (void)setCustomView;
//外部segment点击更改selectIndex,切换页面
@property (assign, nonatomic) NSInteger selectIndex;

@end
