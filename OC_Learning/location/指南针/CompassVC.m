//
//  CompassVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import "CompassVC.h"
#import "CoreLocation/CoreLocation.h"
@interface CompassVC ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *compassView;
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation CompassVC
- (CLLocationManager *)manager
{
    if(!_manager){
        _manager = [[CLLocationManager alloc] init];
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        //每隔10米打印一次
        _manager.distanceFilter = 10;
        [_manager requestAlwaysAuthorization];
        _manager.delegate = self;
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.创建位置管理者
    //2.使用位置管理者，获取当前设备朝向
    if ([CLLocationManager headingAvailable]) {
        [self.manager startUpdatingHeading];
    }else{
        NSLog(@"当前磁力计设备损坏");
    }
   
}

#pragma mark-CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"%@",newHeading);
    //1.拿到当前设备朝向
    //0-359.9角度
    CLLocationDirection angle = newHeading.magneticHeading;
    
    //把角度转为弧度
    double hudu = angle/180*M_PI;
    //2.反向旋转图片
    [UIView animateWithDuration:(0.5) animations:^{
            self.compassView.transform = CGAffineTransformMakeRotation(-hudu);
        }];
   
}




@end

