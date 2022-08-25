//
//  AreaMonitoringVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import "AreaMonitoringVC.h"
#import "CoreLocation/CoreLocation.h"
@interface AreaMonitoringVC ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
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
    
    //判断当前区域是否可以监听
    if ([CLLocationManager isMonitoringAvailableForClass:NSClassFromString(@"CLCircularRegion")]) {
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(21.123, 123.354);
        CLLocationDistance distance = 1000;
        if (distance>self.manager.maximumRegionMonitoringDistance) {
            distance = self.manager.maximumRegionMonitoringDistance;
        }
        CLCircularRegion *regin = [[CLCircularRegion alloc ] initWithCenter:center radius: distance identifier:@"lin"];
        
        [self.manager startMonitoringForRegion:regin];
        
        //请求某个区域的状态
        [self.manager requestStateForRegion:regin];
    }
    
    
  
}

#pragma mark-CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入区域");
    self.noticeLabel.text = @"进入区域";
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开区域");
    self.noticeLabel.text = @"离开区域";
}
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if([region.identifier isEqual: @"lin"]){
        if (state == CLRegionStateInside) {
            self.noticeLabel.text = @"在里面";
        }else if (state == CLRegionStateOutside){
            self.noticeLabel.text = @"在外面";
        }else{
            self.noticeLabel.text = @"未知";
        }
    }
}
@end
