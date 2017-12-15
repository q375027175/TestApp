//
//  NSObject+PerformSelector.m
//  testApp
//
//  Created by 崔关 on 2017/12/14.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "NSObject+PerformSelector.h"
#import "SwizzleMethod.h"

@implementation NSObject (PerformSelector)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        swizzleMethod(self, @selector(performSelector: withObject:), @selector(perform_PerformSelector: withObject:));
//
//        swizzleMethod(self, @selector(performSelector:), @selector(perform_PerformSelector:));
//
//    });
//}

-(id)perform_PerformSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self perform_PerformSelector:aSelector];
    }
    return nil;
}

- (id)perform_PerformSelector:(SEL)aSelector withObject:(id)object {
    if ([self respondsToSelector:aSelector]) {
        return [self perform_PerformSelector:aSelector withObject:object];
    }
    return nil;
}

@end

