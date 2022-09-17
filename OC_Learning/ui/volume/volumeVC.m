//
//  volumeVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "volumeVC.h"

@interface volumeVC ()
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation volumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    
    //复制层
    CAReplicatorLayer *replicatorL = [CAReplicatorLayer layer];
//    replicatorL.backgroundColor = [UIColor greenColor].CGColor;
    replicatorL.frame = self.contentV.bounds;
    [self.contentV.layer addSublayer:replicatorL];
    
    //创建一个条
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 1);
    layer.bounds = CGRectMake(0, 0, 30, 100);
    layer.position = CGPointMake(0, self.contentV.bounds.size.height);
//    layer.frame = CGRectMake(0, self.contentV.bounds.size.height-100, 30, 100);
    [replicatorL addSublayer:layer];
    
    //添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
    
    
    
    
    //复制的份数(包括他自己)
    replicatorL.instanceCount = 6;
    //对复制出来的子层进行平移操作(每一个都是相对于上一个子层做的形变)
    replicatorL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    //设置复制出来的子层动画延迟执行时长
    replicatorL.instanceDelay = 1;
    
    
    
    ///复制图片制作倒影
    NSLog(@"%@",self.view.layer);
    CAReplicatorLayer *rep = (CAReplicatorLayer *)self.view.layer;
    rep.instanceCount  = 2;
    rep.instanceRedOffset -= 0.1;
    rep.instanceGreenOffset -= 0.1;
    rep.instanceBlueOffset -= 0.1;
    rep.instanceAlphaOffset -= 0.1;
    //绕着复制层的锚点旋转
    rep.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
}


@end
