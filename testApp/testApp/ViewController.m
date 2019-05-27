//
//  ViewController.m
//  testApp
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "ViewController.h"
#import "PlaceViewController.h"
#import "DouyuViewController.h"
#import "KaidengViewController.h"
#import "JiequUrlViewController.h"
#import "UITableView+NoDataView.h"
#import "JiequURLUIWebviewViewController.h"
#import "HuaDongYemianViewController.h"
#import "THuadongViewController.h"
#import "dianhuabenViewController.h"
#import "QHuadongViewController.h"
#import "CalendarViewController.h"
#import "LoginViewController.h"
#import "JianbianViewController.h"
#import "CGUtlis.h"
#import "NSData+Aes.h"
#import <CommonCrypto/CommonDigest.h>
#import "CGWaterWaveView.h"
#import "NFCViewController.h"
#import "HeartBeatViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@interface Base:NSObject
@end

@interface Base2:Base
@end

@implementation Base
- (void)f {
    NSLog(@"base f");
}
@end

@implementation Base2

- (void)f {
    NSLog(@"base2 f");
}

@end


@implementation ViewController

- (void)testDelegate {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollToBack];
    
    Base2 *a = [[Base2 alloc] init];
    Base *b = a;
    Base2 *c = a;
    
    [b f];
    [c f];
//    return;
    
    NSArray *numbers = @[@448.42, @571.92, @694.02, @812.31, @924.84, @603.42, @726.92, @849.02, @967.31, @1079.84, @751.42, @874.92, @997.02, @1115.31, @1227.84];
    NSArray *number2 = @[@802.5, @743.2, @686.7, @628.08, @578.5, @874.5, @815.2, @758.7, @700.08, @650.5, @948.8, @889.5, @833, @774.38, @724.8];
    for (NSNumber *num in numbers) {
        NSInteger index = [numbers indexOfObject:num];
        
        NSNumber *num2 = number2[[numbers indexOfObject:num]];
        CGFloat as = num.floatValue + 98.5;
        CGFloat bs = num2.floatValue + 60.5;
        
//        NSLog(@"this.tudis[%zd] = this.tudi%zd_%zd;\nthis.shus[%zd] = this.shu%zd_%zd;", index, (index / 5) + 1, (index % 5) + 1,  index, (index / 5) + 1, (index % 5) + 1);
        
        NSLog(@"<ns1:CustomImage id=\"tudi%zd_%zd\" source=\"land-1_png\" x=\"%.2f\" y=\"%.2f\" anchorOffsetX=\"98.5\" anchorOffsetY=\"60.5\"/>\n<ns1:CustomImage id=\"shu%zd_%zd\" source=\"tree_png\" x=\"%.2f\" y=\"%.2f\" anchorOffsetX=\"35\" anchorOffsetY=\"47.5\"/>", 3 - ((index / 5)), (index % 5) + 1, as,bs, 3 - ((index / 5)), (index % 5) + 1, as + 6, bs - 47.5 + 6);
        
    }
//    return;

    CGLog(@"%@", [self token]);
    self.title = @"首页";
    self.array = @[@"登陆",@"附近有啥", @"直播",@"手电筒",@"解析网页",@"解析网页UIWebView",@"scroll滑动页面", @"tableview滑动页面", @"Q滑动页面", @"电话本", @"日历",@"颜色渐变", @"NFC", @"心跳"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.showMessage = @"啥也没有";
    [self.tableView reloadData];
    
//    NSDate *date = [NSDate date];
//    NSMutableArray *muArr = [NSMutableArray array];
//    for (NSInteger i = 1; i <= date.daysInMonth; i ++) {
//        NSDate *firstDate = [NSDate dateWithYear:date.year month:date.month day:i];
//        [muArr addObject:@{@"days":@(i), @"weekday":@(firstDate.weekday)}];
//    }
//    
//    NSInteger weekDay1 = 7 - [muArr.firstObject[@"weekday"] integerValue];
//    for (NSInteger i = 0; i < weekDay1; i ++) {
//        [muArr insertObject:@{} atIndex:0];
//    }
//    
//    NSInteger weekDay2 = 7 - [muArr.lastObject[@"weekday"] integerValue];
//    for (NSInteger i = 0; i < weekDay2; i ++) {
//        [muArr addObject:@{}];
//    }
//    
//    [self setStrings:@"A", @"B", @"C", @"D", @"E", @"F",
//     @"G", @"H", @"I", @"J", @"Q", @"L", @"M", @"N", @"O", @"P",
//     @"Q", @"I", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",
//      nil];
//    
//    NSInteger x = 0;
//    
//    while ((x = x + 1) < 10) {
////        CGLog(@"~~~~~~~~~~~%zd", x);
//    }
    
//    [self lock];
//    [self lock];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        float freeDisk = [CGUtlis diskOfFreeSizeMBytes];
//        float allDisk = [CGUtlis diskOfAllSizeMBytes];
//        CGLog(@"%.2f \n %.2f", allDisk, freeDisk);
//    });
    
//    CGWaterWaveView *wave = [[CGWaterWaveView alloc] init];
//    wave.frame = CGRectMake(50, 50, 200, 200);
//    wave.center = CGPointMake(kWIDTH / 2, kHEIGHT / 2);
//    [self.view addSubview:wave];
//    [wave startWaveToPercent:1];
//
//    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        [wave removeFromSuperview];
//    }];
}

- (void)setStrings:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION {
    CGLog(@"传多个参数的第一个参数 %@",string);//是other1

    va_list args;
    va_start(args, string);
    
    if (string) {
        NSMutableArray *muArr = [NSMutableArray arrayWithObject:string];
        NSString *str = nil;
        while ((str = va_arg(args, NSString *))) {
            if (str) {
                [muArr addObject:str];
                CGLog(@"其他: %@", str);
            }
        }
        
        CGLog(@"muArr count = %zd", muArr.count);
    }
    va_end(args);
}

- (void)lock {
    //  NSLock
    static NSLock *lock = nil;
    if (!lock) {
        lock = [[NSLock alloc] init];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        CGLog(@"----------------------");
        sleep(10);
        [lock unlock];
    });
    // @synchronized
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            CGLog(@"～～～～～～～～～～～～～");
            sleep(10);
        }
    });
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row]; //self.array[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    NSString *title = self.array[indexPath.row];
    
    if ([title isEqualToString:@"附近有啥"]) {
        vc = [[PlaceViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        [self presentViewController:vc animated:YES completion:nil];
//        return;
    } else if ([title isEqualToString:@"直播"]) {
        vc = [[DouyuViewController alloc] init];
    } else if ([title isEqualToString:@"手电筒"]) {
        vc = [[KaidengViewController alloc] init];
    } else if ([title isEqualToString:@"解析网页"]) {
        vc = [[JiequUrlViewController alloc] init];
    } else if ([title isEqualToString:@"解析网页UIWebView"]) {
        vc = [[JiequURLUIWebviewViewController alloc] init];
    } else if ([title isEqualToString:@"scroll滑动页面"]) {
        vc = [[HuaDongYemianViewController alloc] init];
    } else if ([title isEqualToString:@"tableview滑动页面"]) {
        vc = [[THuadongViewController alloc] init];
    } else if ([title isEqualToString:@"电话本"]) {
        vc = [[dianhuabenViewController alloc] init];
    } else if ([title isEqualToString:@"Q滑动页面"]) {
        vc = [[QHuadongViewController alloc] init];
    } else if ([title isEqualToString:@"日历"]) {
        vc = [[CalendarViewController alloc] init];
    } else if ([title isEqualToString:@"登陆"]) {
        vc = [[LoginViewController alloc] init];
    } else if ([title isEqualToString:@"颜色渐变"]) {
        vc = [[JianbianViewController alloc] init];
    } else if ([title isEqualToString:@"NFC"]) {
        vc = [[NFCViewController alloc] init];
    } else if ([title isEqualToString:@"心跳"]) {
        vc = [[HeartBeatViewController alloc] init];
    }
    
    if (vc) {
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 44.0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSString *)token {
//    @"AiMaGoo2016!@."
    
    NSString *s = @"U2FsdGVkX19kKiZcwM+9B62V1NLXHGmfLntfnsyIs3BQdd9aWbQDEisUEXFTQYy9";
    
    NSString *a = [self HMACMD5WithString:@"123456" WithKey:@"123456"];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    
    
    NSString *string = [NSString stringWithFormat:@"/admin/login:%.0f", time];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    data = [data AES256EncryptWithKey:a];
    
    data = [NSData AES128EncryptWithKey:a iv:@"1234567890123456" withNSData:data];
    NSString *token = [data base64EncodedStringWithOptions:0];
    
//    NSString *token = [NSData aes128_encrpt:string key:a];
    
    NSString *b = [NSString stringWithFormat:@"bearer admin:%@:admin", token];
    return b;
}

//- (NSString *) md5:(NSString *) input {
//    const char *cStr = [input UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
//
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//
//    return  output;
//}
//
//+ (NSString *)LJHMACMD5:(NSString *)data key:(NSString *)key {
//    NSData *datas = [data dataUsingEncoding:NSUTF8StringEncoding];
//    size_t dataLength = datas.length;
//    NSData *keys = [key dataUsingEncoding:NSUTF8StringEncoding];
//    size_t keyLength = keys.length;
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgMD5, [keys bytes], keyLength, [datas bytes], dataLength, result);
//    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
//        printf("%d ",result[i]);
//    }
//    printf("\n-------%s-------\n",result);
//    //这里需要将result 转base64编码，再传回去
//    //为了简单这里没有做
//    NSString *base64 = [NSString stringWithUTF8String:result];
//    //因为没做base64编码，所以result转NSString 转换失败，是NULL
//    return base64;
//}
//
- (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr
{
    const char *cKey  = [keyStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [toEncryptStr cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned long keyLen = strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    }
    else {
        memcpy(keypad, cKey, keyLen);
    }
    
    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);
    
    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding];

    return hash;
}

@end
