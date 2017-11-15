//
//  SocketSkin.m
//  PingAnWiFi
//
//  Created by 蒋周 on 15/2/10.
//  Copyright (c) 2015年 Ping An Insurance(Group) Company of China, Ltd. All rights reserved.
//

#import "PAWiFiSocketSkin.h"
#import "PAWiFiRadioSocket.h"
#import "PAWiFiGCDAsyncSocket.h"
#import "PAWiFiConstants.h"
@interface PAWiFiSocketSkin ()<GCDAsyncSocketDelegate>

@end

typedef void(^finishedPost)(BOOL success, NSString *response);

@implementation PAWiFiSocketSkin{
    /**
      * 对象
      */
    PAWiFiGCDAsyncSocket * _socket;
    
    /**
      * 请求字符串
      */
    NSString *request;
    
    /**
      * 代码回调块
      */
    finishedPost _finishPost;
    
    /**
      * 接受数据
      */
    NSMutableData *_data;
    
    /**
      * 请求数据
      */
    NSMutableData *_reqdata;
    BOOL isConnected;
    
    /**
      * 目的地址
      */
    NSData *_dsa;
    /**
      * 重连次数
      */
    int  _conn_count;
}
static NSMutableArray *_sockets;

-(void)socketDidDisconnect:(PAWiFiGCDAsyncSocket *)sock withError:(NSError *)err{
    if (_data.length>0) {
        //[self procData];
    }else {
        _conn_count++;
        if (_conn_count>5) {
            _finishPost(NO,@"没有数据");
            return;
        }
        [_socket connectToAddress:_dsa viaInterface:@"pdp_ip0" withTimeout:10 error:nil];
    }
}
-(void)procData{
    NSString *resp= [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
//     NSLog(@"%@",resp);
    if (resp.length) {
        NSArray *comps=[resp componentsSeparatedByString:@"\r\n"];
        NSMutableString *result=[NSMutableString new];
        BOOL body_start=NO;
        for (int i=0; i<comps.count; i++) {
            if (body_start) {
                [result appendString:comps[i]];
            }
            if ( !body_start && ((NSString*)comps[i]).length==0) {
                body_start=YES;
                continue;
            }
        }
        //JSON 响应必须解析json数据{}
        NSRange range=[result rangeOfString:@"{"];
        if (range.location!=NSNotFound) {
            NSInteger st=range.location;
            
            range=[result rangeOfString:@"}" options:NSBackwardsSearch];
            if (range.location!=NSNotFound) {
                NSInteger en=range.location;
                range.location=st;
                range.length=en-st+1;
                
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    _finishPost(YES,[result substringWithRange:range]);
//                });
            }else{
                _finishPost(NO,@"没有数据");
            }
        }else{
            _finishPost(NO,@"没有数据");
        }
    }else{
        _finishPost(NO,@"没有数据");
    }
    //删除访问对象
    [_sockets removeObject:self];
    
}
-(void)socket:(PAWiFiGCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    [_data appendData:data];
    [self procData];
}

-(void)socket:(PAWiFiGCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    isConnected=YES;
    [_socket readDataWithTimeout:-1 tag:10];
    [_socket writeData:_reqdata withTimeout:-1 tag:10];
}

+(void)sendRequest:(NSString *)req withBody:(NSString*)body toHost:(NSString *)host andPort:(int)port  withFinished:(void (^)(BOOL success,NSString *response))finishBlcok{
    
    [PAWiFiSocketSkin sendRequest:req withBody:body toHost:host andPort:port withData:nil withFinished:finishBlcok];
}
+(void)sendRequest:(NSString *)req withBody:(NSString *)body toHost:(NSString *)host andPort:(int)port withData:(NSData *)data withFinished:(void (^)(BOOL, NSString *))finishBlcok{
    if (!_sockets) {
        _sockets=[NSMutableArray array];
    }
    PAWiFiSocketSkin *socketskin=[PAWiFiSocketSkin new];
    [_sockets addObject:socketskin];
    [socketskin interSendRequest:req withBody:body toHost:host andPort:port withData:data withFinished:finishBlcok];
}

-(void)interSendRequest:(NSString *)req withBody:(NSString *)body toHost:(NSString *)host andPort:(int)port withData:(NSData *)data withFinished:(void (^)(BOOL, NSString *))finishBlcok{
    /**
     * 确定设置captivenetwork
     */
    NSArray *SSIDs = @[[PAWiFiRadioSocket GetCurrentSSID]];
    CNSetSupportedSSIDs((__bridge CFArrayRef) SSIDs);
    
    
    _finishPost = finishBlcok;
    _socket = [[PAWiFiGCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [_socket setDelegate:self];
    
    NSError *err;
    //    [socket connectToHost:host onPort:port viaInterface:@"pdp_ip0" withTimeout:2 error:&err];
    struct sockaddr_in remoteAddr ;
    struct sockaddr sa ;
    bzero(&sa,sizeof(struct sockaddr_in));
    remoteAddr.sin_family=AF_INET;
    remoteAddr.sin_addr.s_addr= inet_addr([host cStringUsingEncoding:NSASCIIStringEncoding]);
    remoteAddr.sin_port=htons(port);
    
    NSData *dsa = [NSData dataWithBytes:&remoteAddr length:sizeof(remoteAddr)];
    _dsa=dsa;
    [_socket connectToAddress:dsa viaInterface:@"pdp_ip0" withTimeout:10 error:&err];
    if (err != nil)
    {
        _finishPost(NO,@"没有数据");
        return;
    }
    NSString *temp=@"POST %@ HTTP/1.1\r\n\
Accept: text/html\r\n\
Connection: close\r\n\
Host: 127.0.0.1\r\n\
User-Agent: Mozilla/4.0 (compatible; MSIE 4.01; Windows 98)\r\n\
Content-Type: application/x-www-form-urlencoded\r\n\
Content-Length: %d\r\n\
Accept-Encoding: gzip, deflate\r\n\
\r\n%@\r\n\n";
    NSInteger len=0;
    if (body) {
        len=body.length;
    }else{
        body=@"";
    }
    if (data) {
        len+=data.length;
    }
    request = [NSString stringWithFormat:temp,req,len,body];
    
    /**
      * 接收响应数据
      */
    _data = [NSMutableData data];
    
    /**
      * 请求数据
      */
    NSMutableData *reqdata=[NSMutableData dataWithData:[request dataUsingEncoding:NSUTF8StringEncoding]];
    if (data) {
        [reqdata appendData:data];
    }
    _reqdata = reqdata;
}
- (void)dealloc{
    _socket.delegate = nil;
    _socket = nil;
    
}
@end
