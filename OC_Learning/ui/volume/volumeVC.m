//
//  volumeVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "volumeVC.h"

@interface volumeVC ()
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end

@implementation volumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建一个条
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 1);
    layer.bounds = CGRectMake(0, 0, 30, 100);
    layer.position = CGPointMake(0, self.contentV.bounds.size.height);
//    layer.frame = CGRectMake(0, self.contentV.bounds.size.height-100, 30, 100);
    [self.contentV.layer addSublayer:layer];
    
    //添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
}


@end
