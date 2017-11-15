//
//  TYPlaceManager.m
//  TongYi
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import "TYPlaceManager.h"
#import <TencentLBS/TencentLBS.h>

@interface TYPlaceManager()<TencentLBSLocationManagerDelegate>

@property (strong, nonatomic) PlaceManagerCallBack response;
@property (readwrite, nonatomic, strong) TencentLBSLocationManager *locationManager;

@end

@implementation TYPlaceManager

+ (void)getPlaceArrayWithResponse:(PlaceManagerCallBack) response {
    TYPlaceManager *manager = [self sharePlaceManager];
    manager.response = response;
    [manager configLocationManager];
}

+ (instancetype)sharePlaceManager {
    static TYPlaceManager *manager = nil;
    if (!manager) {
        manager = [[TYPlaceManager alloc] init];
    }
    return manager;
}

- (void)configLocationManager {
    [self.locationManager cancelRequestLocation];
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined && [self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])            {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager requestLocationWithCompletionBlock:^(TencentLBSLocation * _Nullable location, NSError * _Nullable error) {
        self.response(location);
    }];
}

#pragma mark - TencentLBSLocationManagerDelegate

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                 didFailWithError:(NSError *)error {
}

- (TencentLBSLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[TencentLBSLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setApiKey:@"JIZBZ-LC5WF-X54JP-NTWPK-ED3QK-KLBDL"];
    }
    return _locationManager;
}
@end
