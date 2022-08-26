//
//  GeocodingVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import "GeocodingVC.h"
#import "CoreLocation/CoreLocation.h"

@interface GeocodingVC ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *CityTextView;
@property (weak, nonatomic) IBOutlet UITextField *jingdu;
@property (weak, nonatomic) IBOutlet UITextField *weidu;
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLGeocoder *geoCoder;
@end

@implementation GeocodingVC
- (CLLocationManager *)manager
{
    if(!_manager){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.distanceFilter = 100;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestAlwaysAuthorization];
    }
    return _manager;
}
- (CLGeocoder *)geoCoder
{
    if(!_geoCoder){
        _geoCoder = [[CLGeocoder alloc]init];
    }
    return  _geoCoder;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.manager startUpdatingLocation];
    
    
}

//反地理编码 经纬度->地址
- (IBAction)enCoding:(id)sender {
    NSLog(@"%@",self.jingdu.text);
    NSLog(@"%@",self.weidu.text);
    CLLocation *location = [[CLLocation alloc]initWithLatitude: [self.jingdu.text doubleValue] longitude:[self.weidu.text doubleValue]];
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error==nil){
            if(!placemarks){
                return;
            }
            NSLog(@"%@",placemarks.firstObject.name);
            /*
             CLPlacemark
             location:地标对象对应的位置对象
             name：地址详情
             */
            
        }else{
            NSLog(@"错了！！！%@",error.localizedDescription);
        }
        self.CityTextView.text = placemarks.firstObject.name;
    }];
}

//地理编码 地址->经纬度
- (IBAction)deCoding:(id)sender {
    
    NSLog(@"City：%@",self.CityTextView.text);
    [self.geoCoder geocodeAddressString:self.CityTextView.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error==nil){
            if(!placemarks){
                return;
            }
            NSLog(@"%@",placemarks.firstObject.name);
        }else{
            NSLog(@"错了！！！%@",error.localizedDescription);
        }
        self.jingdu.text = [NSString stringWithFormat:@"%f",placemarks.firstObject.location.coordinate.latitude];
        self.weidu.text = [NSString stringWithFormat:@"%f",placemarks.firstObject.location.coordinate.longitude];
    }];
    
    
    
  
}

#pragma mark-CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = locations.lastObject;
    if (!newLocation) {
        return;
    }
    if (newLocation.horizontalAccuracy<0) {
        return;
    }
    NSLog(@"newLocation:%@",newLocation);
    NSLog(@"%f",newLocation.coordinate.longitude);
    NSLog(@"%f",newLocation.coordinate.latitude);
    CLLocation *location = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    NSLog(@"location:%@",location);
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error==nil){
            NSLog(@"反地理编码的结果%@",placemarks.firstObject.locality);
        }else{
            NSLog(@"错误🙅：%@",error.localizedDescription);
        }
    }];
    [self.manager stopUpdatingLocation];
}
@end
