//
//  NetworkStatusVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/17.
//

#import "NetworkStatusVC.h"
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
@interface NetworkStatusVC ()
@property(nonatomic,strong) Reachability *r;
@end

@implementation NetworkStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self network];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(network2) name:@"kReachabilityChangedNotification" object:nil];
    Reachability *r = [Reachability reachabilityForLocalWiFi];
    [r startNotifier];
    self.r = r;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) network
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //监听状态改变
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

-(void) network2
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //监听状态改变
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
