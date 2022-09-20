//
//  StockTabBarVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/19.
//

#import "StockTabBarVC.h"
#import "MyLotteryVC.h"
#import "HallVC.h"
#import "DiscoverVC.h"
#import "ArenaVC.h"
#import "HistoryVC.h"
#import "LinTabBar.h"

@interface StockTabBarVC ()<LinTabBarDelegate>
@property(nonatomic,strong)NSMutableArray* array;
@end

@implementation StockTabBarVC
- (NSMutableArray *)array
{
    if(_array == nil){
        _array = [NSMutableArray array];
    }
    return  _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    ArenaVC *vc1 = [[ArenaVC alloc ] init];
    HallVC *vc = [[HallVC alloc ] init];
    DiscoverVC *vc2 = [[DiscoverVC alloc ] init];
    vc2.view.backgroundColor = [UIColor greenColor];
    HistoryVC *vc3 = [[HistoryVC alloc ] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    MyLotteryVC *vc4 = [[MyLotteryVC alloc ] init];
    vc4.view.backgroundColor = [UIColor greenColor];
    [self setupChildren:vc title:@"购票大厅"];
    [self setupChildren:vc1 title:@"竞技场"];
    [self setupChildren:vc2 title:@"发现"];
    [self setupChildren:vc3 title:@"开奖信息"];
    [self setupChildren:vc4 title:@"我的"];
    [self setupTabBar];

}

//自定义tabbar
-(void)setupTabBar
{
    //移除系统tabbar
    [self.tabBar removeFromSuperview];
    LinTabBar *tabBar = [[LinTabBar alloc]init];
//    tabBar.tabBarCount = self.childViewControllers.count;
    tabBar.items = self.array;
    [self.view addSubview:tabBar];
    tabBar.backgroundColor = [UIColor grayColor];
    tabBar.frame = self.tabBar.frame;
    tabBar.delegate = self;
}

-(void) setupChildren:(UIViewController *)vc title:(NSString *) titleName
{
    
//    vc.view.backgroundColor = [UIColor redColor];
    vc.tabBarItem.title = titleName;
    [self addChildViewController:vc];
    [self.array addObject:vc.tabBarItem];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
 

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark- LinTabBarDelagate
- (void)linTabBar:(LinTabBar *)tabBar index:(NSInteger)index
{
    //切换子控制器
    self.selectedIndex = index;
}
@end
