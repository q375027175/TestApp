//
//  SocketSkin.h
//  PingAnWiFi
//
//  Created by 蒋周 on 15/2/10.
//  Copyright (c) 2015年 Ping An Insurance(Group) Company of China, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAWiFiSocketSkin : NSObject


+(void)sendRequest:(NSString *)req withBody:(NSString*)body toHost:(NSString *)host andPort:(int)port withFinished:(void (^)(BOOL success,NSString *response))finishBlcok;

/**
 *  @param  req  请求地址
 *  
 */
+(void)sendRequest:(NSString *)req withBody:(NSString*)body toHost:(NSString *)host andPort:(int)port withData:(NSData*)data withFinished:(void (^)(BOOL success,NSString *response))finishBlcok;


@end
