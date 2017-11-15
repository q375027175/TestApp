//
//  BaseViewController.h
//  testApp
//
//  Created by juge on 2017/10/30.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setScrollToBack; //／ 设置滑动返回
- (UINavigationController *)getNavigationConller; ///返回包含有ViewController的navigationController

@end
