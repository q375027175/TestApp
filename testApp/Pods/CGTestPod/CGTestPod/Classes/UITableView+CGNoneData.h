//
//  UITableView+CGNoneData.h
//  CGTestPod_Tests
//
//  Created by 崔关 on 2017/11/30.
//  Copyright © 2017年 q375027175. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef BOOL (^CompareBlock)(void);

@interface UITableView (CGNoneData)

//设置无数据展示的信息
- (void)setShowMessage:(NSString *)showMessage;

// 注意循环引用!!!!!
- (void)setShowNoDataViewCompara:(CompareBlock) block;
@end

