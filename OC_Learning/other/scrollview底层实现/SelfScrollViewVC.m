//
//  SelfScrollViewVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "SelfScrollViewVC.h"

@interface SelfScrollViewVC ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIView *scrollView;
@end
/*
 模仿系统控件=>怎么去使用=>滚动scrollview本质上是内容在滚动 =>改bounds
 
 手指往上， bounds的y++，内容才会往上走
 */
@implementation SelfScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        UIView *scrollView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:scrollView];
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [scrollView addGestureRecognizer:pan];
    self.scrollView = scrollView;
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
//    scrollView.contentSize = CGSizeMake(0, 1000);
//    scrollView.delegate = self;
//    [self.view addSubview:scrollView];
    UISwitch *switchView = [[UISwitch alloc] init];
    [scrollView addSubview:switchView];
    
}

-(void) pan:(UIPanGestureRecognizer *)pan
{
    //修改bounds
    CGPoint transP =  [pan translationInView:pan.view];
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.y -= transP.y;
    self.scrollView.bounds = bounds;
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
}

#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromCGRect(scrollView.bounds));
}
@end
