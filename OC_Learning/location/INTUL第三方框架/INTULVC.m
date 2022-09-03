//
//  INTULVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/26.
//

#import "INTULVC.h"
#import "INTULocationManager.h"

@interface INTULVC ()

@end

@implementation INTULVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"INTlocation";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    INTULocationManager  *locationManager = [INTULocationManager sharedInstance];
    /*
     delayUntilAuthorized 超市时间从什么时候开始计算
     true:从用户授权之后开始计算
     false:从执行这个代码开始计算
     */
    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if(status == INTULocationStatusSuccess){
            NSLog(@"location:%@",currentLocation);
        }
           
    }];
}


@end
