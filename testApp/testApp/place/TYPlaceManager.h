//
//  TYPlaceManager.h
//  TongYi
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYPlaceManager : NSObject

typedef void(^PlaceManagerCallBack) (id response);

+ (void)getPlaceArrayWithResponse:(PlaceManagerCallBack) response;

@end
