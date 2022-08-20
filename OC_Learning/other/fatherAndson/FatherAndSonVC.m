//
//  FatherAndSonVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/20.
//

#import "FatherAndSonVC.h"
#import "SocietyVC.h"
#import "TopVC.h"
#import "HotVC.h"
@interface FatherAndSonVC ()
@property(nonatomic,strong) SocietyVC *societyVC;
@property(nonatomic,strong) TopVC *topVC;
@property(nonatomic,strong) HotVC *hotVC;
@property (weak, nonatomic) IBOutlet UIView *titleContainView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation FatherAndSonVC

/*
 存在问题
 1.控制器每次都需要创建
 2.控制器的view每次都被加上去
 3.控制器的view不能处理业务逻辑，控制器被销毁了
 */

//点击社会
//- (IBAction)clickSoiety:(id)sender {
//    //把设置控制器的view添加上去
//    //解决：控制器每次都需要创建,控制器的view不能处理业务逻辑，控制器被销毁了
//    if(_societyVC==nil){
//        SocietyVC *vc = [[SocietyVC alloc] init];
//        vc.view.frame = CGRectMake(0, 31,  self.view.bounds.size.width, self.view.bounds.size.height-31);
//        _societyVC = vc;
//    }
//
//    //addSubView:把一个view加上去，先判断一下这个view有没有父控件，如果有，会拿到这个view，先从父控件移除，再添加，解决：控制器的view每次都被加上去
//    [self.view addSubview:_societyVC.view];
//}
//点击头条
//- (IBAction)clickTop:(id)sender {
//    if(_topVC==nil){
//        TopVC *vc = [[TopVC alloc] init];
//        vc.view.frame = CGRectMake(0, 31,  self.view.bounds.size.width, self.view.bounds.size.height-31);
//        _topVC = vc;
//    }
//
//    [self.view addSubview:_topVC.view];
//}
//点击热点
//- (IBAction)clickHot:(id)sender {
//    if(_hotVC==nil){
//        HotVC *vc = [[HotVC alloc] init];
//        vc.view.frame = CGRectMake(0, 31,  self.view.bounds.size.width, self.view.bounds.size.height-31);
//        _hotVC = vc;
//    }
//
//    [self.view addSubview:_hotVC.view];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网易云";
    //开发规范：如果A控制器的view添加到B控制器的view上，那么A控制器必须成为B控制器的子控制器
    //通过psuh进行页面跳转时，会将当前视图从导航控制器移除，再添加新的控制器
    
    //present的dismiss：判断当前方法调用者是否被modal，如果不是，判断父控制器是否被modal
    
    
    //实现父子控制器
    /*
     1.添加所有子控制器
     2.设置对应按钮的内容
     */
    [self setupAllViewController];
    [self setupTitleButton];
}

//设置按钮的内容
-(void)setupTitleButton
{
    NSInteger count = self.titleContainView.subviews.count;
    for(int i = 0;i<count;i++)
    {
        UIButton *btn = self.titleContainView.subviews[i];
        UIViewController *sub = self.childViewControllers[i];
        [btn setTitle:sub.title forState:UIControlStateNormal];
    }
}
//添加所有的子控制器
-(void)setupAllViewController
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
}
//点击标题按钮
- (IBAction)showChildView:(UIButton *)sender {
    //移除之前的view
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    for (UIView *view in self.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    //把对应子控制器的view添加上去
    UIViewController *vc = self.childViewControllers[sender.tag];
    vc.view.backgroundColor = sender.backgroundColor;
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"hahah");
}

@end
