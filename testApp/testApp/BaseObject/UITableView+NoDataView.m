//
//  UITableView+NoDataView.m
//  testApp
//
//  Created by juge on 2017/10/30.
//  Copyright © 2017年 juge. All rights reserved.
//


#import "UITableView+NoDataView.h"
#import <objc/runtime.h>

#define defaultNoDataMessage @"暂无数据"

#define noDataViewKey @"noDataViewKey"
#define showMessageKey @"showMessageKey"
#define noDataLabelKey @"noDataLabelKey"

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
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UILabel *noDataLabel;
@end

@implementation UITableView (NoDataView)

+ (void)replaceMethod {
    static BOOL i = NO;
    if (i) return;
    i = YES;
    
    Class tableviewClass = [self class];
    
    SEL reloadDataSel = @selector(reloadData);
    Method reloadDataMethod = class_getInstanceMethod(tableviewClass, reloadDataSel);
    char *reloadType = (char *)method_getTypeEncoding(reloadDataMethod);
    IMP reloadIMP = method_getImplementation(reloadDataMethod);

    SEL noDataView_reloadData_Sel = @selector(noDataView_reloadData);
    Method nodataView_reloadData_method = class_getInstanceMethod(tableviewClass, noDataView_reloadData_Sel);
    char *nodataView_type = (char *)method_getTypeEncoding(nodataView_reloadData_method);
    IMP nodataView_reloadData_IMP = method_getImplementation(nodataView_reloadData_method);


    BOOL success = class_addMethod(tableviewClass, reloadDataSel, nodataView_reloadData_IMP, nodataView_type);
    if (success) {
        class_replaceMethod(tableviewClass, noDataView_reloadData_Sel, reloadIMP, reloadType);
    } else {
        method_exchangeImplementations(reloadDataMethod, nodataView_reloadData_method);
    }
    
}

- (void)noDataView_reloadData {
    CGLog(@"modataView_reloadData");
    [self noDataView_reloadData];
//    [self reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.visibleCells.count && self.visibleCells.count > 0) {
            self.backgroundView = nil;
        } else {
            if (!self.noDataView) [self initNodataView];
            self.backgroundView = self.noDataView;
        }
    });
}

- (void)initNodataView {
    self.noDataView = [[UIView alloc] init];
    self.noDataView.backgroundColor = [UIColor whiteColor];
    self.noDataLabel = [[UILabel alloc] init];
    self.noDataLabel.text = defaultNoDataMessage;
    self.noDataLabel.textColor = [UIColor grayColor];
    self.noDataLabel.textAlignment = NSTextAlignmentCenter;
    [self.noDataView addSubview:self.noDataLabel];
    
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.top.equalTo(@100);
    }];
}

- (void)setNoDataView:(UIView *)noDataView {
    objc_setAssociatedObject(self, noDataViewKey, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)noDataView {
    UIView *noDataView = objc_getAssociatedObject(self, noDataViewKey);
    return noDataView;
}

- (void)setNoDataLabel:(UILabel *)noDataLabel {
    objc_setAssociatedObject(self, noDataLabelKey, noDataLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)noDataLabel {
    return objc_getAssociatedObject(self, noDataLabelKey);
}

- (void)setShowMessage:(NSString *)showMessage {
    if (!self.noDataView) [self initNodataView];
    self.noDataLabel.text = self.showMessage?:defaultNoDataMessage;

    objc_setAssociatedObject(self, showMessageKey, showMessage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)showMessage {
    return objc_getAssociatedObject(self, showMessageKey);
}

@end
