//
//  CGUtlis.h
//  testApp
//
//  Created by 崔关 on 2018/1/3.
//  Copyright © 2018年 juge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGUtlis : NSObject

/**
 获取当前设备可用内存

 @return 当前设备可用内存
 */
+ (double)availableMemory;


/**
 获取当前任务占用内存

 @return 当前任务占用内存
 */
+ (double)usedMemory;

/**
 获取磁盘总大小
 返回单位为M（兆）

 @return 磁盘总大小
 */
+ (CGFloat)diskOfAllSizeMBytes;


/**
 获取磁盘可用空间
 返回单位为M（兆）

 @return 磁盘可用空间
 */
+ (CGFloat)diskOfFreeSizeMBytes;
@end
