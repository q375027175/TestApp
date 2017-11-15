//
//  BaseViewController.m
//  testApp
//
//  Created by juge on 2017/10/30.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    [self setNavigationBackItem];
}

- (void)setScrollToBack {
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)initNavigationBar {
    self.navigationController.navigationBar.translucent = NO;
}

- (UINavigationController *)getNavigationConller {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}

- (void)setNavigationBackItem {
    if (!self.navigationController || self.navigationController.viewControllers.count <= 0 || self.navigationController.viewControllers.firstObject == self) return; // 如果没有NavigationController或者当前显示的页面是rootViewController 不加返回按钮
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    [backButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [backButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [backButton addTarget:self action:@selector(navigationPopToLastViewController) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)navigationPopToLastViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    CGLog(@"dealloc");
}

@end
