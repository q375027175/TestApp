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
    
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBar.translucent = NO;

//    [self initNavigationBar];
//    [self setNavigationBackItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setScrollToBack];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (@available(iOS 11, *)) {
        UINavigationItem * item=self.navigationItem;
        NSArray * array=item.leftBarButtonItems;
        if (array&&array.count!=0){
            //这里需要注意,你设置的第一个leftBarButtonItem的customeView不能是空的,也就是不要设置UIBarButtonSystemItemFixedSpace这种风格的item
            UIBarButtonItem * buttonItem=array[0];
            UIView * view =[[[buttonItem.customView superview] superview] superview];
            NSArray * arrayConstraint=view.constraints;
            for (NSLayoutConstraint * constant in arrayConstraint) {
                if (fabs(constant.constant)==20 || fabs(constant.constant)==16) {
                    constant.constant=0;
                }
            }
        }
    }
}

// 滑动返回设置
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if([self isFirstOfNavigationController]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)setScrollToBack {
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)initNavigationBar {
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forBarMetrics:UIBarMetricsDefault];
//    NSDictionary *attri = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
//    self.navigationController.navigationBar.titleTextAttributes = attri;
}

- (void)QKPushViewController:(UIViewController *)viewController {
    if (!viewController) return;
    if ([self isFirstOfNavigationController]) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (BOOL)isFirstOfNavigationController {
    return (!self.navigationController || self.navigationController.viewControllers.count <= 0 || self.navigationController.viewControllers.firstObject == self);
}

- (UINavigationController *)getNavigationConller {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}

- (void)setNavigationBackItem {
    if ([self isFirstOfNavigationController]) return; // 如果没有NavigationController或者当前显示的页面是rootViewController 不加返回按钮
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    [backButton setImage:[UIImage imageNamed:@"goback"] forState:(UIControlStateNormal)];
    backButton.frame= CGRectMake(0, 0, 44, 44);
    [backButton addTarget:self action:@selector(QKPopViewController) forControlEvents:(UIControlEventTouchUpInside)];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backView sizeToFit];
    [backView addSubview:backButton];
    if (@available(iOS 11, *)) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    } else {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSeperator,backItem,nil];
    }
}

- (UIButton *)setRightItemWithImg:(NSString *)img {
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    [rightButton setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    rightButton.frame= CGRectMake(0, 0, 44, 44);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backView sizeToFit];
    [backView addSubview:rightButton];
    if (@available(iOS 11, *)) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    } else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSeperator,rightItem,nil];
    }
    
    return rightButton;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)QKPopViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    CGLog(@"dealloc");
}

@end


