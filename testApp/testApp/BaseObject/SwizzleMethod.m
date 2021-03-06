//
//  SwizzleMethod.m
//  testApp
//
//  Created by 崔关 on 2017/12/2.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "SwizzleMethod.h"
#import <objc/runtime.h>

typedef id(* _IMP)(id, SEL,...);
typedef void(* _VIMP)(id, SEL,...);

/*
 [obj class]; 获取的是类对象
 object_getClass(class);  获取的是元类对象，也就是类对象的 isa         Class _Nonnull isa
 */

// swizzled
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // 更改实例方法 用的是类对象
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void swizzleClassMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    class = object_getClass(class);   // 更改类方法必须获取到元类对象而不是类对象
    
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void swizzleMehod(Class class, SEL originalSelector, id _Nonnull block) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);

    _VIMP originalIMP = (_VIMP)class_getMethodImplementation(class, originalSelector);
    method_setImplementation(originalMethod, imp_implementationWithBlock(block));
    
    
    method_setImplementation(originalMethod, imp_implementationWithBlock(^(id target, SEL action){
        originalIMP(target, action);// 调用被替换掉的方法
        
    }));
}

