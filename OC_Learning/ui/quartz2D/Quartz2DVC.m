//
//  Quartz2DVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "Quartz2DVC.h"
#import "DrawView.h"
/*
 图形上下文：是一个CGContextRef类型的数据
 图形上下文的作用：保存绘图信息，绘图状态；决定绘制的输出目标(PDF,Bitmap或者显示器的窗口上)
 drawRect会自动创建图形上下文
 */
@interface Quartz2DVC ()
@property(nonatomic,strong)DrawView *selfView;
@end

@implementation Quartz2DVC
- (UIView *)selfView
{
    if(_selfView==nil){
        _selfView  = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _selfView.center = self.view.center;
        _selfView.backgroundColor = [UIColor orangeColor];
    }
    return _selfView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selfView];
}


@end
