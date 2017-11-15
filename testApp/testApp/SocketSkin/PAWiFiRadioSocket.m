//
//  RadioSocket.m
//  RadioSocket
//
//  Created by 蒋周 on 15/1/30.
//  Copyright (c) 2015年 蒋周. All rights reserved.
//

#import "PAWiFiRadioSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <net/if_dl.h>
#include <sys/socket.h>
#include <sys/types.h>
#import <unistd.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <net/if_dl.h>
#include <sys/ioctl.h>

@implementation PAWiFiRadioSocket

+ (BOOL)is3GUp {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    BOOL ret=NO;
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    if( (temp_addr->ifa_flags & IFF_UP)==IFF_UP){
                        ret=YES;
                    }
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return ret;
}
+ (NSString*)wifiIp {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    NSString *wifiIp=@"";
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    wifiIp = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return wifiIp;
}
+ (NSString*)get3Gip {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    NSString *wwwIp=@"";
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    wwwIp = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return wwwIp;
}
+(NSString*)GetCurrentSSID
{
    NSString *str_ssid= paWiFiUNKNOWWIFI;
    CFArrayRef aInterface=NULL;
    aInterface=CNCopySupportedInterfaces();
    if (aInterface!=NULL && CFArrayGetCount(aInterface)>0)
    {
        const void* a=CFArrayGetValueAtIndex(aInterface, 0);
        CFStringRef strInterface=(CFStringRef)a;
        CFDictionaryRef aCurrent= CNCopyCurrentNetworkInfo(strInterface);
        if (aCurrent!=NULL && CFDictionaryGetCountOfKey(aCurrent, kCNNetworkInfoKeySSID)==1)
        {
            CFStringRef ssid=(CFStringRef)CFDictionaryGetValue(aCurrent, kCNNetworkInfoKeySSID);
            char strData[512]={0};
            CFStringGetCString(ssid, strData, 511, kCFStringEncodingUTF8);
            str_ssid=[[NSString alloc] initWithUTF8String:strData];
        }
        if (aCurrent!=NULL)
        {
            CFRelease(aCurrent);
        }
    }
    if (aInterface!=NULL)
    {
        CFRelease(aInterface);
    }
    return str_ssid;
}
//
//+(BOOL) NetworkRequestBy3G:(NSString*)host withport:(int)port withURI:(NSString*)uri withFinished:(void (^)(BOOL success,NSString *response))finishBlcok{
//    
//    if([RadioSocket is3GUp]){
//        return NO;
//    }
//    
//    NSArray *SSIDs = @[[RadioSocket GetCurrentSSID]];
//    CNSetSupportedSSIDs((__bridge CFArrayRef) SSIDs);
//    
//    int cfd;
//    struct sockaddr_in s_add;
//    cfd = socket(AF_INET, SOCK_STREAM, 0);
//    if(-1 == cfd)
//    {
//        return NO;
//    }
//    
//    struct sockaddr_in client_addr;
//    bzero(&client_addr,sizeof(client_addr));
//    client_addr.sin_family = AF_INET;
//    NSString *local=[RadioSocket get3Gip];
//    client_addr.sin_addr.s_addr = inet_addr([local cStringUsingEncoding:NSASCIIStringEncoding]);
//    client_addr.sin_port = htons(51118);
//    bind(cfd,(struct sockaddr*)&client_addr,sizeof(struct sockaddr));
//    
//    bzero(&s_add,sizeof(struct sockaddr_in));
//    s_add.sin_family=AF_INET;
//    s_add.sin_addr.s_addr= inet_addr([host cStringUsingEncoding:NSASCIIStringEncoding]);
//    s_add.sin_port=htons(port);
//    
//    
//    if(-1 == connect(cfd,(struct sockaddr *)(&s_add), sizeof(struct sockaddr)))
//    {
//        perror("connect error");
//        NSLog(@"连接错误");
//        return NO;
//    }
//    /**
//     *  千万不能格式化代码, 字符串必须定行,否则有空格在里面协议失效
//     *
//     */
//    NSString *req=@"GET %@ HTTP/1.1\r\n\
//Accept: text/html\r\n\
//Connection: Keep-Alive\r\n\
//Host: 127.0.0.1\r\n\
//User-Agent: Mozilla/4.0 (compatible; MSIE 4.01; Windows 98)\r\n\
//Content-Type: application/x-www-form-urlencoded\r\n\
//Accept-Encoding: gzip, deflate\r\n\
//\r\n";
//    NSString *content=[NSString stringWithFormat:req,uri];
//    write(cfd, [content cStringUsingEncoding:NSASCIIStringEncoding], strlen([content cStringUsingEncoding:NSASCIIStringEncoding]));
//    
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        size_t recbytes;
//        char buffer[1024]={0};
//        if(-1 == (recbytes = read(cfd,buffer,1024)))
//        {
//            finishBlcok(NO,@"接收错误");
//        }else{
//            buffer[recbytes]='\0';
//            NSString *str=[NSString stringWithUTF8String:buffer];
//            finishBlcok(YES,str);
//        }
//        close(cfd);
//   
//    });
//    return YES;
//}
//
//+(int) mkSocket:(NSString*)host withPort:(int)port{
//    
//    int cfd;
//    struct sockaddr_in s_add;
//    cfd = socket(AF_INET, SOCK_STREAM, 0);
//    if(-1 == cfd)
//    {
//        return -1;
//    }
//    
//    struct sockaddr_in client_addr;
//    bzero(&client_addr,sizeof(client_addr));
//    client_addr.sin_family = AF_INET;
//    NSString *local=[RadioSocket get3Gip];
//    client_addr.sin_addr.s_addr = inet_addr([local cStringUsingEncoding:NSASCIIStringEncoding]);
//    client_addr.sin_port = htons(51118);
//    bind(cfd,(struct sockaddr*)&client_addr,sizeof(struct sockaddr));
//    
//    bzero(&s_add,sizeof(struct sockaddr_in));
//    s_add.sin_family=AF_INET;
//    s_add.sin_addr.s_addr= inet_addr([host cStringUsingEncoding:NSASCIIStringEncoding]);
//    s_add.sin_port=htons(port);
//    
//    
//    fd_set rfd;      //描述符集 这个将测试连接是否可用
//    struct timeval timeout;  //时间结构体
//    FD_ZERO(&rfd);//先清空一个描述符集
//    timeout.tv_sec = 2;//秒
//    timeout.tv_usec = 0;//一百万分之一秒，微秒
//    
//    u_long ul=1;//代表非阻塞
//    ioctl(cfd,FIONBIO,&ul);//设置为非阻塞连接
//    
//    bool ret = NO;
//    if( connect(cfd, (struct sockaddr *)&s_add, sizeof(s_add)) == -1)
//    {
//        FD_ZERO(&rfd);
//        FD_SET(cfd, &rfd);
//        if(select(cfd+1, NULL, &rfd, NULL, &timeout)<=0){
//            ret=NO;
//        }else{
//            ret=YES;
//        }
//    }
//    ul=0;//代表阻塞
//    ioctl(cfd,FIONBIO,&ul);//设置为阻塞连接
//    if(!ret){
//        return -1;
//    }
//    return cfd;
//}

//+(void)NetworkAuthened{
//    CFArrayRef myArray = CNCopySupportedInterfaces();
//    if(CNMarkPortalOnline(CFArrayGetValueAtIndex(myArray, 0))){
//        NSLog(@"CNMarkPortalOnline");
//    }
//}
//+(BOOL)NetworkPostRequestBy3G:(NSString *)host withport:(int)port withURI:(NSString *)uri withBody:(NSString *)body withFinished:(void (^)(BOOL, NSString *))finishBlcok{
//    
//    /**
//      * 判断是否可以连接3G
//      */
//    if(![RadioSocket is3GUp]){
//        return NO;
//    }
//    
//    /**
//      * 确定设置captivenetwork
//      */
//    NSArray *SSIDs = @[[RadioSocket GetCurrentSSID]];
//    BOOL captiveNetworkListUpdated =CNSetSupportedSSIDs((__bridge CFArrayRef) SSIDs);
//    
//    /**
//      * 强制下线模式
//      */
//    CFArrayRef myArray = CNCopySupportedInterfaces();
//    if(CNMarkPortalOffline(CFArrayGetValueAtIndex(myArray, 0))){
//        NSLog(@"portalOffLined");
//    }
//    
//    /*
//      * 模拟调用一次普通网络请求
//      */
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i=0; i<1; i++) {
//            [Constants checkWhetherReachPAHost:^(BOOL canLink) {
//                NSLog(@"Check pa:%d",canLink);
//            }];
//        }
//    });
//    
//    int cfd=-1;
//    for (int i=0; i<10; i++) {
//        NSLog(@"通过3G连接 服务器:%d",i);
//        //通过定时器创建连接, 控制超时
//        cfd =[RadioSocket mkSocket:host withPort:port];
//        if(cfd>0)
//            break;
//    }
//    if(cfd<=0)
//        return NO;
//    
//    
////    if(-1 == connect(cfd,(struct sockaddr *)(&s_add), sizeof(struct sockaddr)))
////    {
////        perror("connect error");
////        NSLog(@"连接错误");
////        return NO;
////    }
//    
//    /**
//      *  千万不能格式化代码, 字符串必须定行,否则有空格在里面协议失效
//      *
//      */
//    NSString *req=@"POST %@ HTTP/1.1\r\n\
//Accept: text/html\r\n\
//Connection: Keep-Alive\r\n\
//Host: 127.0.0.1\r\n\
//User-Agent: Mozilla/4.0 (compatible; MSIE 4.01; Windows 98)\r\n\
//Content-Type: application/x-www-form-urlencoded\r\n\
//Content-Length: %d\r\n\
//Accept-Encoding: gzip, deflate\r\n\
//\r\n%@";
//    int len=0;
//    if (body) {
//        len=body.length;
//    }else{
//        body=@"";
//    }
//    NSString *content=[NSString stringWithFormat:req,uri,len,body];
//    write(cfd, [content cStringUsingEncoding:NSASCIIStringEncoding], strlen([content cStringUsingEncoding:NSASCIIStringEncoding]));
//    
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        NSMutableData *data=[NSMutableData data];
//        //目前的读取接口一次性的获取数据, 目前是设置为64K.
//        int maxlen=1024*64;
//        char *buffer=malloc(maxlen);
//        int len=[RadioSocket Recv:cfd withBuffer:buffer withBufferLen:maxlen];
//
//        close(cfd);
//        if (len<=0) {
//            finishBlcok(NO,@"");
//            return ;
//        }
//        data = [NSMutableData dataWithBytes:buffer length:len];
//        NSString *resp  = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        if (resp.length) {
//            NSArray *comps=[resp componentsSeparatedByString:@"\r\n"];
//            NSMutableString *result=[NSMutableString new];
//            BOOL body_start=NO;
//            for (int i=0; i<comps.count; i++) {
//                if (body_start) {
//                    [result appendString:comps[i]];
//                }
//                if ( !body_start && ((NSString*)comps[i]).length==0) {
//                    body_start=YES;
//                    continue;
//                }
//            }
//            //JSON 响应必须解析json数据{}
//            NSRange range=[result rangeOfString:@"{"];
//            if (range.location!=NSNotFound) {
//                int st=range.location;
//                
//                range=[result rangeOfString:@"}" options:NSBackwardsSearch];
//                if (range.location!=NSNotFound) {
//                    int en=range.location;
//                    range.location=st;
//                    range.length=en-st+1;
//                    finishBlcok(YES,[result substringWithRange:range]);
//                }
//            }
//        }
//    });
//    return YES;
//}
//
//
////return value, -1 means Recv happs error; 0 means timeout or be interupted; > 0 means ok
//+(int) Recv:(int) sock_fd withBuffer:( char *) recvbuf withBufferLen:(int) recvbuflen
//{
//    fd_set fds_red;
//    struct timeval tval;
//    int selret = 0;
//    tval.tv_sec = 3;
//    tval.tv_usec = 0;
//    //while(1)
//    {
//        //we must clear fds for every loop, otherwise can not check the change of descriptor
//        FD_ZERO(&fds_red);
//        FD_SET(sock_fd, &fds_red);
//        
//        selret = select(sock_fd + 1, &fds_red, NULL, NULL, &tval);
//        
//        if(selret < 0)
//        {
//            if(errno == EINTR)
//            {
//                return 0;
//            }
//            else
//            {
//                return -1;
//            }
//        }
//        else if(selret == 0)
//        {
//            return 0;
//        }
//        else
//        {
//            
//            if(FD_ISSET(sock_fd, &fds_red))
//            {
//                bool brecvres = true;
//                //receive data
//                int recvlen = 0;
//                int retlen = 0;
//                char *ptr = recvbuf;
//                int leftlen = recvbuflen -1;
//                do
//                {
//                    retlen = recv(sock_fd, ptr, leftlen, 0) ;
//                    if(retlen < 0)
//                    {
//                        if(errno == EAGAIN || errno == EWOULDBLOCK)
//                        {
//                            break;
//                        }
//                        else if(errno == EINTR )
//                        {
//                            retlen = 0;
//                        }
//                        else
//                        {
//                            return -1;
//                        }
//                    }
//                    else if(retlen == 0)
//                    {
//                        return -1;
//                    }
//                    recvlen += retlen;
//                    leftlen -= retlen;
//                    ptr += retlen;
//                    break;
//                }
//                while(0);
//                
////                printf("receive data is : %s", recvbuf);
//                return recvlen;
//                
//            }  
//            else  
//            {  
//                return -1;  
//            }  
//        }  
//    }  
//}

@end
