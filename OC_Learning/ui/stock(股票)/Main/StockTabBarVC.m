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
#import "UIImage+Image.h"

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
    vc1.view.backgroundColor = [UIColor orangeColor];
    HallVC *vc = [[HallVC alloc ] init];
    vc.view.backgroundColor = [UIColor blueColor];
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
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
       [appearance configureWithOpaqueBackground];
       appearance.backgroundColor = [UIColor redColor];
       appearance.shadowColor = [UIColor whiteColor];
//       appearance.shadowImage = [UIImage imageWithColor:[UIColor whiteColor]];
//    appearance.shadowImage = [UIImage imagewithC];
//
//    appearance.shadowImage = [UIImage ];
    UIImage *img = [self imageWithColor:[UIColor orangeColor]];
    appearance.shadowImage = img;
      
    //包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.navigationBar.standardAppearance = appearance;
    nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance;
    //给导航条设置背景图片只能设置为普通模式，用其他模式图片无法显示
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    dictM[NSForegroundColorAttributeName] = [UIColor blueColor];
    [nav.navigationBar setTitleTextAttributes:dictM];
    //导航控制器上的内容由栈顶控制器决定
    vc.tabBarItem.title = titleName;
    vc.navigationItem.title = titleName;
    
    [self addChildViewController:nav];
    [self.array addObject:vc.tabBarItem];

}
//隐藏本身的导航栏
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
-(UIImage *) imageWithColor:(UIColor *)color
{
    //描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //渲染上希望
    CGContextFillRect(context, rect);
    //从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return  theImage;
}
@end
