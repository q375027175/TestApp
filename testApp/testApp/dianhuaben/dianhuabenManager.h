//
//  dianhuabenManager.h
//  testApp
//
//  Created by juge on 2017/10/31.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^dianhuabenBlock)(NSArray *addressArr);
@interface dianhuabenManager : NSObject
+ (instancetype)shareManager;
- (void)getDianhuabenContentiOS8WithBlock:(dianhuabenBlock)block;

@end
