//
//  UITableView+CGNoneData.m
//  CGTestPod_Tests
//
//  Created by 崔关 on 2017/11/30.
//  Copyright © 2017年 q375027175. All rights reserved.
//

#import "UITableView+CGNoneData.h"
#import <objc/runtime.h>
#import "TestNoDataView.h"

#define noDataViewKey @"noDataViewKey"
#define comparaBlockKey @"comparaBlockKey"

// swizzled
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
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


@interface UITableView ()
@property (nonatomic, strong) TestNoDataView *noDataView;
@property (nonatomic, copy) CompareBlock compareBlock;
@end

@implementation UITableView (CGNoneData)
+ (void)load {
    static BOOL i = NO;
    if (i) return;
    i = YES;
    swizzleMethod(self, @selector(reloadData), @selector(noDataView_reloadData));
    swizzleMethod(self, @selector(deleteSections:withRowAnimation:), @selector(noDataView_deleteSections:withRowAnimation:));
}

- (void)noDataView_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self noDataView_deleteSections:sections withRowAnimation:animation];
    [self compareAndHidden];
}

- (void)noDataView_reloadData {
    [self noDataView_reloadData];
    [self compareAndHidden];
}

- (void)setShowNoDataViewCompara:(CompareBlock) block {
    self.compareBlock = block;
}

- (void)compareAndHidden {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.compareBlock && self.compareBlock()) {
            self.noDataView.hidden = NO;
        } else {
            self.noDataView.hidden = YES;
        }
    });
}

#pragma mark - setter  getter
- (void)setCompareBlock:(CompareBlock)compareBlock {
    objc_setAssociatedObject(self, comparaBlockKey, compareBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CompareBlock)compareBlock {
    return objc_getAssociatedObject(self, comparaBlockKey);
}

- (void)setNoDataView:(TestNoDataView *)noDataView {
    objc_setAssociatedObject(self, noDataViewKey, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)noDataView {
    TestNoDataView *noDataView = objc_getAssociatedObject(self, noDataViewKey);
    if (!noDataView) {
        noDataView = [[TestNoDataView alloc] init];
        noDataView.hidden = YES;
        [self addSubview:noDataView];
        [self setNeedsLayout];
        
        noDataView.frame = self.bounds;
        
        [self setNoDataView:noDataView];
    }
    
    return noDataView;
}

- (void)setShowMessage:(NSString *)showMessage {
    [self.noDataView setShowMessage:showMessage];
}

@end
