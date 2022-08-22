//
//  FrameAndBoundsVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "FrameAndBoundsVC.h"

@interface FrameAndBoundsVC ()
@property(nonatomic,weak)UIView *redView;
@end

@implementation FrameAndBoundsVC
/*
 frame:以父控件左上角为原点
 bounds:以自己的左上角为原点
 frame和bounds都是用来描述一块区域
 frame:可视范围
 bounds:描述可视范围在内容的区域
 所有的子控件都是相当于内容
 bounds的本质：修改内容的原点
 
 相对性：可视范围相对于父控件位置永远不变，可视范围相对于内容，位置改变
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    view2.backgroundColor = [UIColor blueColor];
    [view addSubview:view2];
    
    self.redView = view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect bounds = self.redView.bounds;
    bounds.origin.y +=10;
    self.redView.bounds = bounds;
}


@end
