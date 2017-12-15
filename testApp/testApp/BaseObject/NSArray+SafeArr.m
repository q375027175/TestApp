//
//  NSArray+SafeArr.m
//  testApp
//
//  Created by 崔关 on 2017/12/14.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "NSArray+SafeArr.h"
#import "SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSArray (SafeArr)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(safe_objectAtIndex:));
        swizzleMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(safeM_objectAtIndex:));
    });
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self safe_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            CGLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            CGLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self safe_objectAtIndex:index];
    }
}

- (id)safeM_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self safe_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            CGLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            CGLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self safeM_objectAtIndex:index];
    }
}

@end
