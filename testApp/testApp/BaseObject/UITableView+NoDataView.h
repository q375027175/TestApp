//
//  UITableView+NoDataView.h
//  testApp
//
//  Created by juge on 2017/10/30.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (NoDataView)

@property (nonatomic ,strong) NSString *showMessage;

+ (void)replaceMethod; //替换方法， AppDelegate 中运行一次

@end
