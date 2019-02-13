//
//  AppDelegate.m
//  testApp
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 juge. All rights reserved.
//
/*
 ////////////////////////////////////////////////////////////////////
 //                          _ooOoo_                               //
 //                         o8888888o                              //
 //                         88" . "88                              //
 //                         (| ^_^ |)                              //
 //                         O\  =  /O                              //
 //                      ____/`---'\____                           //
 //                    .'  \\|     |//  `.                         //
 //                   /  \\|||  :  |||//  \                        //
 //                  /  _||||| -:- |||||-  \                       //
 //                  |   | \\\  -  /// |   |                       //
 //                  | \_|  ''\---/''  |   |                       //
 //                  \  .-\__  `-`  ___/-. /                       //
 //                ___`. .'  /--.--\  `. . ___                     //
 //              ."" '<  `.___\_<|>_/___.'  >'"".                  //
 //            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
 //            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
 //      ========`-.____`-.___\_____/___.-`____.-'========         //
 //                           `=---='                              //
 //      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
 //         佛祖保佑       永无BUG     永不修改                            //
 ////////////////////////////////////////////////////////////////////
 
 
 //////////////////////////////////////////////////////////////////////
 //                        .::::.                                    //
 //                      .::::::::.                                  //
 //                     :::::::::::                                  //
 //                  ..:::::::::::'                                  //
 //               '::::::::::::'                                     //
 //                 .::::::::::                                      //
 //            '::::::::::::::..                                     //
 //                 ..::::::::::::.                                  //
 //               ``::::::::::::::::                                 //
 //                ::::``:::::::::'        .:::.                     //
 //               ::::'   ':::::'       .::::::::.                   //
 //             .::::'      ::::     .:::::::'::::.                  //
 //            .:::'       :::::  .:::::::::' ':::::.                //
 //           .::'        :::::.:::::::::'      ':::::.              //
 //          .::'         ::::::::::::::'         ``::::.            //
 //      ...:::           ::::::::::::'              ``::.           //
 //     ```` ':.          ':::::::::'                  ::::..        //
 //                        '.:::::'                    ':'````..     //
 //////////////////////////////////////////////////////////////////////
 
 ┌──────────────────────────────────────────────────────────────────────────┐
 │                       ::                                                 │
 │                      :;J7, :,                        ::;7:               │
 │                      ,ivYi, ,                       ;LLLFS:              │
 │                      :iv7Yi                       :7ri;j5PL              │
 │                     ,:ivYLvr                    ,ivrrirrY2X,             │
 │                     :;r@Wwz.7r:                :ivu@kexianli.            │
 │                    :iL7::,:::iiirii:ii;::::,,irvF7rvvLujL7ur             │
 │                   ri::,:,::i:iiiiiii:i:irrv177JX7rYXqZEkvv17             │
 │                ;i:, , ::::iirrririi:i:::iiir2XXvii;L8OGJr71i             │
 │              :,, ,,:   ,::ir@mingyi.irii:i:::j1jri7ZBOS7ivv,             │
 │                 ,::,    ::rv77iiiriii:iii:i::,rvLq@huhao.Li              │
 │             ,,      ,, ,:ir7ir::,:::i;ir:::i:i::rSGGYri712:              │
 │           :::  ,v7r:: ::rrv77:, ,, ,:i7rrii:::::, ir7ri7Lri              │
 │          ,     2OBBOi,iiir;r::        ,irriiii::,, ,iv7Luur:             │
 │        ,,     i78MBBi,:,:::,:,  :7FSL: ,iriii:::i::,,:rLqXv::            │
 │        :      iuMMP: :,:::,:ii;2GY7OBB0viiii:i:iii:i:::iJqL;::           │
 │       ,     ::::i   ,,,,, ::LuBBu BBBBBErii:i:i:i:i:i:i:r77ii            │
 │      ,       :       , ,,:::rruBZ1MBBqi, :,,,:::,::::::iiriri:           │
 │     ,               ,,,,::::i:  @arqiao.       ,:,, ,:::ii;i7:           │
 │    :,       rjujLYLi   ,,:::::,:::::::::,,   ,:i,:,,,,,::i:iii           │
 │    ::      BBBBBBBBB0,    ,,::: , ,:::::: ,      ,,,, ,,:::::::          │
 │    i,  ,  ,8BMMBBBBBBi     ,,:,,     ,,, , ,   , , , :,::ii::i::         │
 │    :      iZMOMOMBBM2::::::::::,,,,     ,,,,,,:,,,::::i:irr:i:::,        │
 │    i   ,,:;u0MBMOG1L:::i::::::  ,,,::,   ,,, ::::::i:i:iirii:i:i:        │
 │    :    ,iuUuuXUkFu7i:iii:i:::, :,:,: ::::::::i:i:::::iirr7iiri::        │
 │    :     :rk@Yizero.i:::::, ,:ii:::::::i:::::i::,::::iirrriiiri::,       │
 │     :      5BMBBBBBBSr:,::rv2kuii:::iii::,:i:,, , ,,:,:i@petermu.,       │
 │          , :r50EZ8MBBBBGOBBBZP7::::i::,:::::,: :,:,::i;rrririiii::       │
 │              :jujYY7LS0ujJL7r::,::i::,::::::::::::::iirirrrrrrr:ii:      │
 │           ,:  :@kevensun.:,:,,,::::i:i:::::,,::::::iir;ii;7v77;ii;i,     │
 │           ,,,     ,,:,::::::i:iiiii:i::::,, ::::iiiir@xingjief.r;7:i,    │
 │        , , ,,,:,,::::::::iiiiiiiiii:,:,:::::::::iiir;ri7vL77rrirri::     │
 │         :,, , ::::::::i:::i:::i:i::,,,,,:,::i:i:::iir;@Secbone.ii:::     │
 └──────────────────────────────────────────────────────────────────────────┘


 ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
 │┌───┐   ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┐                  │
 ││Esc│   │ F1│ F2│ F3│ F4│ │ F5│ F6│ F7│ F8│ │ F9│F10│F11│F12│ │P/S│S L│P/B│  ┌┐    ┌┐    ┌┐  │
 │└───┘   └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┘  └┘    └┘    └┘  │
 │┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐ ┌───┬───┬───┐ ┌───┬───┬───┬───┐│
 ││~ `│! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│ BacSp │ │Ins│Hom│PUp│ │N L│ / │ * │ - ││
 │├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤ ├───┼───┼───┤ ├───┼───┼───┼───┤│
 ││ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│ | \ │ │Del│End│PDn│ │ 7 │ 8 │ 9 │   ││
 │├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤ └───┴───┴───┘ ├───┼───┼───┤ + ││
 ││ Caps │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│ Enter  │               │ 4 │ 5 │ 6 │   ││
 │├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤     ┌───┐     ├───┼───┼───┼───┤│
 ││ Shift  │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│  Shift   │     │ ↑ │     │ 1 │ 2 │ 3 │   ││
 │├─────┬──┴─┬─┴──┬┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤ ┌───┼───┼───┐ ├───┴───┼───┤ E│││
 ││ Ctrl│    │Alt │         Space         │ Alt│    │    │Ctrl│ │ ← │ ↓ │ → │ │   0   │ . │←─┘││
 │└─────┴────┴────┴───────────────────────┴────┴────┴────┴────┘ └───┴───┴───┘ └───────┴───┴───┘│
 └─────────────────────────────────────────────────────────────────────────────────────────────┘
 
 
 **************************************************************
 *                                                            *
 *   .=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-.       *
 *    |                     ______                     |      *
 *    |                  .-"      "-.                  |      *
 *    |                 /            \                 |      *
 *    |     _          |              |          _     |      *
 *    |    ( \         |,  .-.  .-.  ,|         / )    |      *
 *    |     > "=._     | )(__/  \__)( |     _.=" <     |      *
 *    |    (_/"=._"=._ |/     /\     \| _.="_.="\_)    |      *
 *    |           "=._"(_     ^^     _)"_.="           |      *
 *    |               "=\__|IIIIII|__/="               |      *
 *    |              _.="| \IIIIII/ |"=._              |      *
 *    |    _     _.="_.="\          /"=._"=._     _    |      *
 *    |   ( \_.="_.="     `--------`     "=._"=._/ )   |      *
 *    |    > _.="                            "=._ <    |      *
 *    |   (_/                                    \_)   |      *
 *    |                                                |      *
 *    '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='      *
 *                                                            *
 *           LASCIATE OGNI SPERANZA, VOI CH'ENTRATE           *
 **************************************************************
 
 
 
 
 
 
 
 頂頂頂頂頂頂頂頂頂　頂頂頂頂頂頂頂頂頂
 頂頂頂頂頂頂頂　　　　　頂頂
 　　　頂頂　　　頂頂頂頂頂頂頂頂頂頂頂
 　　　頂頂　　　頂頂頂頂頂頂頂頂頂頂頂
 　　　頂頂　　　頂頂　　　　　　　頂頂
 　　　頂頂　　　頂頂　　頂頂頂　　頂頂
 　　　頂頂　　　頂頂　　頂頂頂　　頂頂
 　　　頂頂　　　頂頂　　頂頂頂　　頂頂
 　　　頂頂　　　頂頂　　頂頂頂　　頂頂
 　　　頂頂　　　　　　　頂頂頂
 　　　頂頂　　　　　　頂頂　頂頂　頂頂
 　頂頂頂頂　　　頂頂頂頂頂　頂頂頂頂頂
 　頂頂頂頂　　　頂頂頂頂　　　頂頂頂頂

 */

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "PlaceViewController.h"
#import "DouyuViewController.h"
#import "KaidengViewController.h"
#import "JiequUrlViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AMapServices sharedServices].apiKey = @"6ed9c493b110856b3f4464839da0b8c2";
    [Bmob registerWithAppKey:@"d7a1b5304281d7850ff594f3f76a18d9"];
    
    if (@available(iOS 11, *)) { // iOS 11 tableview 适配
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = [vc getNavigationConller];
    
    
    // 后台刷新
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] != UIBackgroundRefreshStatusAvailable)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您没有开启后台刷新，请在 设置->通用->应用程序后台刷新 中开启." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }

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
    
    completionHandler(UIBackgroundFetchResultNewData);

}

//如果iOS版本低于9.0，会在下面方法接受到在地址栏输入的字符串
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"sourceApplication->%@", [url absoluteString]] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return YES;
}
//如果iOS版本是9.0及以上的，会在下面方法接受到在地址栏输入的字符串
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"openURL->%@", [url absoluteString]] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return YES;
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
