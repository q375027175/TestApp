//
//  BaseNavigationController.m
//  testApp
//
//  Created by 崔关 on 2017/11/16.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController) return;
    if (self.viewControllers.count == 1) {
        UIViewController *vc = self.viewControllers.lastObject;
        vc.hidesBottomBarWhenPushed = YES;
        [super pushViewController:viewController animated:YES];
        vc.hidesBottomBarWhenPushed = NO;
    } else {
        if (self.viewControllers.count > 1) {
            self.viewControllers.lastObject.hidesBottomBarWhenPushed = YES;
        }
        [super pushViewController:viewController animated:YES];
    }
}

@end
