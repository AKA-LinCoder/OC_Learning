//
//  Quartz2DVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "Quartz2DVC.h"
#import "DrawView.h"
#import "processView.h"
#import "pieView.h"
/*
 图形上下文：是一个CGContextRef类型的数据
 图形上下文的作用：保存绘图信息，绘图状态；决定绘制的输出目标(PDF,Bitmap或者显示器的窗口上)
 drawRect会自动创建图形上下文
 */
@interface Quartz2DVC ()
@property(nonatomic,strong)DrawView *selfView;
@property(nonatomic,strong)processView *selfProcessView;
@property(nonatomic,strong)UISlider *sliderView;
@property(nonatomic,strong)pieView *selfpie;
@end

@implementation Quartz2DVC
- (pieView *)selfpie
{
    if (_selfpie==nil) {
        if(_selfpie==nil){
            _selfpie  = [[pieView alloc] initWithFrame:CGRectMake(50, 700, 200, 200)];
            _selfpie.backgroundColor = [UIColor grayColor];
        }
        return _selfpie;
    }
    return _selfpie;
}
- (UIView *)selfView
{
    if(_selfView==nil){
        _selfView  = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _selfView.center = self.view.center;
        _selfView.backgroundColor = [UIColor orangeColor];
    }
    return _selfView;
}

- (UISlider *)sliderView
{
    if (_sliderView == nil) {
        _sliderView = [[UISlider alloc] initWithFrame:CGRectMake(50, 500, 200, 40)];
        [_sliderView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderView;
}

- (processView *)selfProcessView
{
    if(_selfProcessView==nil){
        _selfProcessView  = [[processView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
//        _selfProcessView.center = self.view.center;
//        _selfProcessView.backgroundColor = [UIColor redColor];
        NSLog(@"_selfProcessView的儿子们%@",_selfProcessView.subviews);
    }
    return _selfProcessView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selfView];
    [self.view addSubview:self.selfProcessView];
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.selfpie];
}

-(void) valueChanged:(UISlider *)slider
{
    //获取进度值
    //两个%代表一个
    self.selfProcessView.label.text = [NSString stringWithFormat:@"%.2f%%",slider.value*100];
    [self.selfProcessView.label sizeToFit];
    self.selfProcessView.value = slider.value;
}

@end
