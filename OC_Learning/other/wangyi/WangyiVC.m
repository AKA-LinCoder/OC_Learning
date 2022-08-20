//
//  WangyiVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/20.
//

#import "WangyiVC.h"
#import "SocietyVC.h"
#import "TopVC.h"
#import "HotVC.h"
#import "VideoVC.h"
#import "StarVC.h"

@interface WangyiVC ()
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) UIScrollView *titleScrollView;
@property(nonatomic,strong) SocietyVC *societyVC;
@property(nonatomic,strong) TopVC *topVC;
@property(nonatomic,strong) HotVC *hotVC;
@property(nonatomic,strong) UIButton *selectedButton;
@end

@implementation WangyiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"网易新闻";
    //1.添加标题滚动视图
    [self setTitleScrollView];
    //2.添加内容滚动视图
    [self setContentScrollView];
    //3.添加所有子控制器
    [self setupAllChildController];
    //4.添加所有标题
    [self setupAllTitle];
    //5.处理标题点击
}
#pragma mark-添加标题滚动视图
-(void) setTitleScrollView
{
    //创建scrollview
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    CGFloat y = self.navigationController.navigationBarHidden?64:104;
    titleScrollView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 44);
    titleScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
}
#pragma mark-添加内容滚动视图
-(void) setContentScrollView
{
    //创建scrollview
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    contentScrollView.backgroundColor = [UIColor systemBlueColor];
    contentScrollView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height-y);
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
}

#pragma mark-添加所有子控制器
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
    StarVC *startVC = [[StarVC alloc] init];
    startVC.title = @"明星";
    [self addChildViewController:startVC];
}
#pragma mark-添加所有标题
-(void) setupAllTitle
{
    
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
    //添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i<count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        btnX = i*btnW;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        titleButton.tag = i;
        //监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0){
            [self titleClick:titleButton];
        }
        [self.titleScrollView addSubview:titleButton];
    }
    //设置标题滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count *btnW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    //设置内容滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count *[UIScreen mainScreen].bounds.size.width, 0);
}

#pragma  mark-选中标题
-(void)selButton:(UIButton *)button
{
    [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.selectedButton = button;
}

#pragma mark-标题点击
-(void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    //1.标题颜色切换
    [self selButton:button];
    UIViewController *vc = self.childViewControllers[i];
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    //3.内容滚动视图到响应位置
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    //2.对应子控制view添加
}
@end
