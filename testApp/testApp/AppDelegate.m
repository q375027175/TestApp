//
//  AppDelegate.m
//  testApp
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "PlaceViewController.h"
#import "DouyuViewController.h"
#import "KaidengViewController.h"
#import "JiequUrlViewController.h"
#import "UITableView+NoDataView.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AMapServices sharedServices].apiKey = @"6ed9c493b110856b3f4464839da0b8c2";
    [UITableView replaceMethod]; // tableView 无数据页面
    
    if (@available(iOS 11, *)) { // iOS 11 tableview 适配
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = [vc getNavigationConller];
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    UIViewController *vc = nil;
    if ([shortcutItem.type isEqualToString:@"location.test.com.testApp"]) {
        vc = [[PlaceViewController alloc] init];
    } else if ([shortcutItem.type isEqualToString:@"douyu.test.com.testApp"]) {
        vc = [[DouyuViewController alloc] init];
    } else if ([shortcutItem.type isEqualToString:@"openCapture.test.com.testApp"]) {
        vc = [[KaidengViewController alloc] init];
    } else if ([shortcutItem.type isEqualToString:@"closeCapture.test.com.testApp"]) {
        vc = [[JiequUrlViewController alloc] init];
    }
    if (vc) {
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:vc animated:YES];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
