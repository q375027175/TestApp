//
//  UIFont+Suit.m
//  testApp
//
//  Created by 崔关 on 2017/12/2.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "UIFont+Suit.h"
#import <objc/runtime.h>
#import "SwizzleMethod.h"

@implementation UIFont (Suit)

+ (void)load {
    static NSInteger i = 0;
    if (i > 0) return;
    i ++;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod(self, @selector(fontWithSize:), @selector(suit_fontWithSize:));
        
        swizzleClassMethod(self, @selector(systemFontOfSize:), @selector(suit_systemFontOfSize:));
        swizzleClassMethod(self, @selector(boldSystemFontOfSize:), @selector(suit_boldSystemFontOfSize:));
    });
}

+ (UIFont *)suit_systemFontOfSize:(CGFloat)fontSize {
    
    fontSize = fontSize < 768? (fontSize * kWIDTH / 375) : fontSize;
    return  [self suit_systemFontOfSize:fontSize];
}

+ (UIFont *)suit_boldSystemFontOfSize:(CGFloat)fontSize {
    
    fontSize = fontSize < 768? (fontSize * kWIDTH / 375) : fontSize;
    return  [self suit_boldSystemFontOfSize:fontSize];
}

- (UIFont *)suit_fontWithSize:(CGFloat)fontSize {
    fontSize = fontSize < 768? (fontSize * kWIDTH / 375) : fontSize;
    return  [self suit_fontWithSize:fontSize];
}


@end
