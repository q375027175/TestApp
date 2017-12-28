//
//  SwizzleMethod.h
//  testApp
//
//  Created by 崔关 on 2017/12/2.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwizzleMethod : NSObject

/**
 在load中保证swizzle只调用一次
+(void)load {
    static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
         swizzleMethod(x,x,x);
     });
}

@param class 需要swizzle的类
@param originalSelector 要被替换的方法
@param swizzledSelector 替换的放法
*/
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

void swizzleClassMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@end
