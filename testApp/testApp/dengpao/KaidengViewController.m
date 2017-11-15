//
//  KaidengViewController.m
//  testApp
//
//  Created by juge on 2017/10/28.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "KaidengViewController.h"
#import <AVFoundation/AVFoundation.h> //调用闪光灯需要导入该框架

@interface KaidengViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation KaidengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button setTitle:@"开灯" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(kaiguandeng:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.button.tag = 0;
    [self kaiguandeng:self.button];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.button.tag = 1;
    [self kaiguandeng:self.button];
}

- (void) kaiguandeng:(UIButton *)sender {
    if (sender.tag == 0) {
        sender.tag = 1;
        [sender setTitle:@"关灯" forState:(UIControlStateNormal)];
        [self openCapture];
    } else if (sender.tag == 1) {
        sender.tag = 0;
        [sender setTitle:@"开灯" forState:(UIControlStateNormal)];
        [self closeCapture];
    }
}

- (void) openCapture {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
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

@end
