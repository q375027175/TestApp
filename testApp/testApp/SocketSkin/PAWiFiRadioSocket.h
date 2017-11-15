//
//  RadioSocket.h
//  RadioSocket
//
//  Created by 蒋周 on 15/1/30.
//  Copyright (c) 2015年 蒋周. All rights reserved.
//

#import <Foundation/Foundation.h>

#define paWiFiUNKNOWWIFI @"unknow"
@interface PAWiFiRadioSocket : NSObject

//+(BOOL) NetworkRequestBy3G:(NSString*)host withport:(int)port withURI:(NSString*)uri withFinished:(void (^)(BOOL success,NSString *response))finishBlcok;

/**
 * 目前仅仅能获取64K的响应数据
 */
//+(BOOL) NetworkPostRequestBy3G:(NSString*)host withport:(int)port withURI:(NSString*)uri withBody:(NSString*)body withFinished:(void (^)(BOOL success,NSString *response))finishBlcok;
+(NSString*)GetCurrentSSID;
+ (BOOL)is3GUp;
+(NSString*) wifiIp;
+(NSString*)get3Gip;

@end
