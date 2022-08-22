//
//  ExtensionWangyiVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "ExtensionWangyiVC.h"
#import "SocietyVC.h"
#import "TopVC.h"
#import "HotVC.h"
#import "VideoVC.h"
#import "StarVC.h"
@interface ExtensionWangyiVC ()

@end

@implementation ExtensionWangyiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //3.添加所有子控制器
    [self setupAllChildController];
}

-(void) setupAllChildController
{
    SocietyVC *societyVC = [[SocietyVC alloc] init];
    societyVC.title = @"社会";

    [self addChildViewController:societyVC];
    HotVC *hotVC = [[HotVC alloc]init];
    hotVC.title = @"热门";
    [self addChildViewController:hotVC];
    TopVC *topVC = [[TopVC alloc ]init];
    topVC.title = @"热点";
    [self addChildViewController:topVC];
    VideoVC *videoVC = [[VideoVC alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
//    StarVC *startVC = [[StarVC alloc] init];
//    startVC.title = @"明星";
//    [self addChildViewController:startVC];
}
#pragma mark

@end
