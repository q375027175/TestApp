//
//  UITableView+NoDataView.h
//  testApp
//
//  Created by juge on 2017/10/30.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^CompareBlock)(void);

@interface UITableView (NoDataView)
//替换方法， AppDelegate 中运行一次
+ (void)replaceMethod;

//设置无数据展示的信息
- (void)setShowMessage:(NSString *)showMessage;

// 注意循环引用!!!!!
// block 返回 BOOL 怎么比较。  YES 显示无数据页面， NO 隐藏无数据页面
- (void)setShowNoDataViewCompara:(CompareBlock) block;

@end
