//
//  AreaMonitoringVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import "AreaMonitoringVC.h"
#import "CoreLocation/CoreLocation.h"
@interface AreaMonitoringVC ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation AreaMonitoringVC
- (CLLocationManager *)manager
{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.distanceFilter  = 10;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.delegate = self;
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(21.123, 123.354);
    CLLocationDistance distance = 1000;
    CLCircularRegion *regin = [[CLCircularRegion alloc ] initWithCenter:center radius: distance identifier:@"lin"];
    
    [self.manager startMonitoringForRegion:regin];
}

#pragma mark-CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入区域");
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开区域");
}
@end
