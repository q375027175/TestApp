//
//  UIScrollView+GoBack.m
//  testApp
//
//  Created by 崔关 on 2017/12/20.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "UIScrollView+GoBack.h"

@implementation UIScrollView (GoBack)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        return YES;
    }else {
        return  NO;
    }
}

@end
