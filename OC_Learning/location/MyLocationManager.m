//
//  MyLocationManager.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import "MyLocationManager.h"

@interface MyLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void(^locationSuccess)(CLLocation *location);
@property (nonatomic, copy) void(^locationFailure)(CLAuthorizationStatus status, NSError *error);

@end

@implementation MyLocationManager

+ (MyLocationManager *)sharedManager {
    static MyLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyLocationManager alloc]init];
    });
    return manager;
}

+ (void)startLocation:(void(^)(CLLocation *location))success failure:(void(^)(CLAuthorizationStatus status, NSError *error))failure {
    [[MyLocationManager sharedManager]startLocation:success failure:failure];
}

+ (void)stopLocation {
    [[MyLocationManager sharedManager]stopLocation];
}

- (void)startLocation:(void(^)(CLLocation *location))success failure:(void(^)(CLAuthorizationStatus status, NSError *error))failure {
    self.locationSuccess = success;
    self.locationFailure = failure;
    [self.locationManager startUpdatingLocation];
}

- (void)stopLocation {
    [self.locationManager stopUpdatingLocation];
}

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        [_locationManager requestAlwaysAuthorization];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 0.1;
    }
    return _locationManager;
}

#pragma mark - CLLocationManagerDelegate

/// 定位成功
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (self.locationSuccess) {
        self.locationSuccess(locations.lastObject);
    }
}

/// 定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (self.locationFailure) {
        if (@available(iOS 14.0, *)) {
            self.locationFailure(manager.authorizationStatus, error);
        } else {
            self.locationFailure([CLLocationManager authorizationStatus], error);
        }
    }
}

/// 定位权限
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse && status != kCLAuthorizationStatusAuthorizedAlways) {
        if (self.locationFailure) {
            self.locationFailure(status, nil);
        }
    }
}

@end
