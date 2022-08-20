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
@end

@implementation FatherAndSonVC

/*
 存在问题
 1.控制器每次都需要创建
 2.控制器的view每次都被加上去
 3.控制器的view不能处理业务逻辑，控制器被销毁了
 */

//点击社会
- (IBAction)clickSoiety:(id)sender {
    //把设置控制器的view添加上去
    //解决：控制器每次都需要创建,控制器的view不能处理业务逻辑，控制器被销毁了
    if(_societyVC==nil){
        SocietyVC *vc = [[SocietyVC alloc] init];
        vc.view.frame = CGRectMake(0, 31,  self.view.bounds.size.width, self.view.bounds.size.height-31);
        _societyVC = vc;
    }
   
    //addSubView:把一个view加上去，先判断一下这个view有没有父控件，如果有，会拿到这个view，先从父控件移除，再添加，解决：控制器的view每次都被加上去
    [self.view addSubview:_societyVC.view];
}
//点击头条
- (IBAction)clickTop:(id)sender {
    if(_topVC==nil){
        TopVC *vc = [[TopVC alloc] init];
        vc.view.frame = CGRectMake(0, 31,  self.view.bounds.size.width, self.view.bounds.size.height-31);
        _topVC = vc;
    }
    
    [self.view addSubview:_topVC.view];
}
//点击热点
- (IBAction)clickHot:(id)sender {
    if(_hotVC==nil){
        HotVC *vc = [[HotVC alloc] init];
        vc.view.frame = CGRectMake(0, 31,  self.view.bounds.size.width, self.view.bounds.size.height-31);
        _hotVC = vc;
    }
  
    [self.view addSubview:_hotVC.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"hahah");
}

@end
