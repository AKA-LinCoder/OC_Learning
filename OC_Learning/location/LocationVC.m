//
//  LocationVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/25.
//

#import "LocationVC.h"
#import "CoreLocation/CoreLocation.h"
#import "MyLocationManager.h"
@interface LocationVC ()<CLLocationManagerDelegate>
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLLocation *lastLocation;
@end

@implementation LocationVC

- (CLLocationManager *)manager
{
    if(!_manager){
        NSLog(@"manager!!");
        _manager = [[CLLocationManager alloc] init];
        //请求的事前台定位授权,默认只能在APP在前台运行时获取信息，如果想在后台运行时也获取定位信息。必须勾选后台模式
//        if (@available(iOS 8.0,*)){
//            [_manager requestWhenInUseAuthorization];
//        }else{
//
//        }
       
        //前后台定位授权
//        [_manager requestAlwaysAuthorization];
        //定位精准度
        /*
          kCLLocationAccuracyBest;
          kCLLocationAccuracyNearestTenMeters;
          kCLLocationAccuracyHundredMeters;
          kCLLocationAccuracyKilometer;
          kCLLocationAccuracyThreeKilometers;
         */
        //如果定位的精准度越高，那么越耗电，而且定位时间越长
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        //每隔10米打印一次
        _manager.distanceFilter = 10;
        //在iOS9以后，如果当前授权状态是前台定位授权，那么你需要勾选后台模式 location updates，还需要额外的设置以下属性为true,必须勾选 location updates,否则只设置以下属性会崩溃
//        _manager.allowsBackgroundLocationUpdates = YES;
        //IOS13之后，就算选的always，第一次也不会提示选择永远，使用一段时间之后才会提示是否变更为永久
        [_manager requestAlwaysAuthorization];
        CLAuthorizationStatus status = _manager.authorizationStatus;
        switch (status) {
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                NSLog(@"前台定位授权");
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"拒绝");
                //判断当前设备是否支持定位，并且定位服务是否开启
                if(CLLocationManager.locationServicesEnabled){
                    NSLog(@"真正拒绝");
                    //手动通过代码，来跳转到设置页面
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if([[UIApplication sharedApplication]canOpenURL:url]){
                        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
                                                    NSLog(@"打开设置");
                                                }];
                    }
                }else{
                    //当我们在app内部想要访问用户位置，但是当前的定位服务是关闭状态，那么系统会自动弹出一个窗口，快速跳转到设置中，让用户设置
                    NSLog(@"定位服务应该开启");
                }
                break;
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@"用户没有决定");
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                NSLog(@"前后台授权");
                break;
            case kCLAuthorizationStatusRestricted:
                NSLog(@"受限制");
                break;
            default:
                break;
        }
        _manager.delegate = self;
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"d",@"const",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    //标准定位：标准定位服务(gps/wifi/蓝牙/基站),内部由苹果自己决定
    //优点：定位精确度高
    //缺点：程序关闭就没法获取位置，而且耗电
    [self.manager startUpdatingLocation];
    //显著位置变化的服务(基站进行定位，一定得有电话模块)
    //优点：当app被完全关闭时，也可以接受到位置通知，并让app进行到后台处理
    //缺点：定位精度低
//    [self.manager startMonitoringSignificantLocationChanges];//适合长时间监控
    //请求一次位置，从定位精度低开始找，在有效时间返回定位到的信息返回
    //不能与startUpdatingLocation同时调用，必须实现代理失败
//    [self.manager requestLocation];
    
//    [MyLocationManager startLocation:^(CLLocation * _Nonnull location) {
//        //定位成功
//        NSLog(@"location::%@",location);
//    } failure:^(CLAuthorizationStatus status, NSError * _Nonnull error) {
//        //定位失败
//    }];
    
}

#pragma mark 

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
//        SuperClassAndClassVC *vc = [[SuperClassAndClassVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
       
    }else if(indexPath.row==1){
//        ConstVC *vc = [[ConstVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
       
//        FatherAndSonVC *vc = [[FatherAndSonVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3){
//        ExtensionWangyiVC *vc = [[ExtensionWangyiVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
//        ScrollviewAutoLayoutVC *vc = [[ScrollviewAutoLayoutVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==5){
//        SizeAndCenterVC *vc = [[SizeAndCenterVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==6){
//        NoticeVC *vc = [[NoticeVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if(indexPath.row ==7){
//        EnumVC *vc = [[EnumVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row == 8){
//        AssignAndWeakVC *vc = [[AssignAndWeakVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==9){
//        FrameAndBoundsVC *vc = [[FrameAndBoundsVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==10){
//        SelfScrollViewVC *vc = [[SelfScrollViewVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==11){
//                BlockVC *vc = [[BlockVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==12){
//        CollectionViewVC *vc = [[CollectionViewVC alloc] init];
//[self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==13){
//        RunLoopUseVC *vc= [[RunLoopUseVC alloc] init];
//        [self presentViewController:vc animated:true completion:nil];
    }
    
}

#pragma  mark-CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = locations.lastObject;
    /*
     coordinate 经纬度
     altitude 海拔
     hAccuracy:如果整个数字是负数，就代表位置数据无效
     vAccuracy：如果整个数字是负数，就代表海拔数据无效
     course：航向
     speed：速度
     distanceFromLocation 计算两个经纬度坐标之前的物理指向距离
     */
    //
//    NSLog(@"位置%@",locations.lastObject);
    if(!newLocation){
        return;
    }
    //获取当前的行走航向
    NSArray<NSString *> *angleStrs = @[@"北偏东",@"东偏南",@"南偏西",@"西偏北"];
    int index = (int)newLocation.course  /90;
    NSString *angleStr = angleStrs[index];
    //行走的偏移量
    int angle = (int)newLocation.course %90;
    
    if ((int) angle == 0) {
        angleStr = [NSString stringWithFormat:@"正%@",[angleStr substringToIndex:1]];
    }
    
    
    //移动了多少距离
    if(!self.lastLocation){
        self.lastLocation = newLocation;
    }
    CLLocationDistance distance =  [newLocation distanceFromLocation:self.lastLocation];
    self.lastLocation = newLocation;
    if ((int) angle != 0) {
        NSLog(@"%@ %d方向，移动了%f米",angleStr,angle,distance);
    }else{
        NSLog(@"%@方向，移动了%f米",angleStr,distance);
    }
  
    
    //获取用户当前所在的城市，切换到对应城市
    //如果想要定位一次，那么可以在定位到之后，停止定位
//    [self.manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    [self.manager startUpdatingLocation];
}
@end

