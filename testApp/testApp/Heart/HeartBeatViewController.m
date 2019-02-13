//
//  HeartBeatViewController.m
//  testApp
//
//  Created by 崔关 on 2019/2/12.
//  Copyright © 2019 juge. All rights reserved.
//

#import "HeartBeatViewController.h"
#import "HeartBeat.h"
#import "HeartLive.h"
#import <AVFoundation/AVFoundation.h> //调用闪光灯需要导入该框架

@interface HeartBeatViewController ()<HeartBeatPluginDelegate>
@property (strong, nonatomic) HeartLive *live;
@property (strong, nonatomic) UILabel *label;

@end

@implementation HeartBeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建了一个心电图的View
    self.live = [[HeartLive alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 150)];
    [self.view addSubview:self.live];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    self.label.layer.borderColor = [UIColor blackColor].CGColor;
    self.label.layer.borderWidth = 1;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:28];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    //开启测心率方法
    [HeartBeat shareManager].delegate = self;
    [[HeartBeat shareManager] start];
    
    /*
     [[HeartBeat shareManager] startHeartRatePoint:^(NSDictionary *point) {
     
     } Frequency:^(NSInteger fre) {
     dispatch_async(dispatch_get_main_queue(), ^{
     self.label.text = [NSString stringWithFormat:@"%ld次/分",(long)fre];
     });
     
     } Error:^(NSError *error) {
     
     }];
     */
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [[HeartBeat shareManager]stop];
     });
     
     */
    [self openCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[HeartBeat shareManager] stop];
    [self closeCapture];
}

- (void) openCapture {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
            [captureDevice setTorchModeOnWithLevel:0.1 error:nil];
            [captureDevice unlockForConfiguration];
        }
    }
}
- (void)closeCapture {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}



#pragma mark - 测心率回调

- (void)startHeartDelegateRatePoint:(NSDictionary *)point {
    NSNumber *n = [[point allValues] firstObject];
    //拿到的数据传给心电图View
    [self.live drawRateWithPoint:n];
    //NSLog(@"%@",point);
}

- (void)startHeartDelegateRateError:(NSError *)error {
    NSLog(@"%@",error);
}

- (void)startHeartDelegateRateFrequency:(NSInteger)frequency {
    NSLog(@"\n瞬时心率：%ld",frequency);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.label) {
            self.label.text = [NSString stringWithFormat:@"%ld次/分",(long)frequency];
        }
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
