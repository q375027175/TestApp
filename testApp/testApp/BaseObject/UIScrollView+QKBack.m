//
//  UIScrollView+QKBack.m
//  testApp
//
//  Created by 崔关 on 2017/11/17.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "UIScrollView+QKBack.h"

@implementation UIScrollView (QKBack)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
    {
        if (self.contentOffset.x <= 0) {
            return YES;
        }
        return NO;
    }
    else
    {
        return  NO;
    }
}

@end
