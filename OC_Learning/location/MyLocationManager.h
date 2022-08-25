//
//  MyLocationManager.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN



@interface MyLocationManager : NSObject

/// 开始定位
+ (void)startLocation:(void(^)(CLLocation *location))success failure:(void(^)(CLAuthorizationStatus status, NSError *error))failure;

/// 结束定位
+ (void)stopLocation;

@end


NS_ASSUME_NONNULL_END
