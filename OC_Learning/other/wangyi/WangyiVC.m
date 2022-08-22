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

@interface WangyiVC ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) UIScrollView *titleScrollView;
@property(nonatomic,strong) UIButton *selectedButton;
@property(nonatomic,strong) NSMutableArray *titleButtons;
@property(nonatomic,assign) BOOL isInitialize;
@end

@implementation WangyiVC
- (NSMutableArray *)titleButtons
{
    if(_titleButtons==nil){
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"网易新闻";
    //iOS7以后导航控制器中scrollView顶部会额外添加64的滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    //1.添加标题滚动视图
    [self setTitleScrollView];
    //2.添加内容滚动视图
    [self setContentScrollView];
    //3.添加所有子控制器
//    [self setupAllChildController];
   
    //5.处理标题点击
    //6.处理内容滚动视图滚动
    //7.将选中标题居中
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isInitialize == NO) {
        //4.添加所有标题
        [self setupAllTitle];
        _isInitialize = YES;
    }
   
}

#pragma mark-添加标题滚动视图
-(void) setTitleScrollView
{
    //创建scrollview
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    CGFloat y = self.navigationController.navigationBarHidden?64:104;
    titleScrollView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 44);
    titleScrollView.backgroundColor = [UIColor orangeColor];
    titleScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
}
#pragma mark-添加内容滚动视图
-(void) setContentScrollView
{
    //创建scrollview
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
//    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height-y);
    contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    //设置代理，监听什么时候滚动完成
    self.contentScrollView.delegate = self;
    
}

#pragma mark-添加所有子控制器
//-(void) setupAllChildController
//{
//    SocietyVC *societyVC = [[SocietyVC alloc] init];
//    societyVC.title = @"社会";
//
//    [self addChildViewController:societyVC];
//    HotVC *hotVC = [[HotVC alloc]init];
//    hotVC.title = @"热门";
//    [self addChildViewController:hotVC];
//    TopVC *topVC = [[TopVC alloc ]init];
//    topVC.title = @"热点";
//    [self addChildViewController:topVC];
//    VideoVC *videoVC = [[VideoVC alloc] init];
//    videoVC.title = @"视频";
//    [self addChildViewController:videoVC];
//    StarVC *startVC = [[StarVC alloc] init];
//    startVC.title = @"明星";
//    [self addChildViewController:startVC];
//}
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
        //把标题按钮保存到数组中
        [self.titleButtons addObject:titleButton];
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
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma  mark-选中标题
-(void)selButton:(UIButton *)button
{
    _selectedButton.transform = CGAffineTransformIdentity;
    [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    //标题居中
    [self setTitleCenter:button];
    //字体缩放,改形变
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.selectedButton = button;
}
#pragma mark- 字体缩放
-(void) setupTitleScale:(UIButton *)button
{
    
  
}
#pragma mark-只要一滚动就需要自提渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //字体缩放：1.缩放比例 2.缩放哪两个按钮
    NSInteger leftI = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    NSInteger rightI = leftI+1;
    //获取左边按钮
    UIButton *leftBtn = self.titleButtons[leftI];
    NSInteger count = self.titleButtons.count;
    //获取右边按钮
    UIButton *rightBtn;
    if (rightI<count) {
        rightBtn = self.titleButtons[rightI];
    }
    
    CGFloat scaleR = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    scaleR -=leftI;
    CGFloat scaleL = 1-scaleR;
    
    //缩放按钮
    leftBtn.transform = CGAffineTransformMakeScale(scaleL*0.3+1, scaleL*0.3+1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR*0.3+1, scaleR*0.3+1);
    //颜色渐变
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    
}

#pragma mark-选中标题居中
-(void) setTitleCenter:(UIButton *)button
{
    //选中按钮的中心点x-屏幕宽度的一半就可以居中
    CGFloat offetX = button.center.x - [UIScreen mainScreen].bounds.size.width*0.5;
    NSLog(@"%f",offetX);
    //左边不移
    if(offetX<0){
        offetX=0;
    }
    //最后一个，最大偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width-[UIScreen mainScreen].bounds.size.width;
    if(offetX>maxOffsetX){
        offetX=maxOffsetX;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offetX, 0) animated:YES];
    
}

#pragma mark-标题点击
-(void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    //1.标题颜色切换
    [self selButton:button];
    [self setupOneViewController:i];
    //3.内容滚动视图到响应位置
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    //2.对应子控制view添加
}
#pragma mark-添加一个子控制器的view
-(void) setupOneViewController:(NSInteger) i
{
    
    UIViewController *vc = self.childViewControllers[i];
    if(vc.view.superview){
        //如果加载了就不必加载
        return;
    }
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}
#pragma mark-UIScrollViewDelegate
//滚动完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
     1/选中标题
     2.把对应子控制器的view添加上去
     */
    //获取当前角标
    NSInteger i  = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    //可能取出其他视图
    UIButton *titleBtn = self.titleButtons[i];
    [self selButton:titleBtn];
    [self setupOneViewController:i];
}
@end
