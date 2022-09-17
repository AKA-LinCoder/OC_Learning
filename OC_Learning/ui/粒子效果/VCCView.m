//
//  VCCView.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "VCCView.h"

@interface VCCView()
@property(nonatomic,strong) UIBezierPath *path;
@property(nonatomic,strong)  CALayer *dotLayer;

@end

@implementation VCCView

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pann:)];
    [self addGestureRecognizer:pan];
    //添加例子
    CALayer *dotLayer  = [CALayer layer];
    dotLayer.frame = CGRectMake(-20, 0, 20, 20);
    dotLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:dotLayer];
    self.dotLayer = dotLayer;
    
    
    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.layer;
    repL.instanceCount = 30;
    //设置动画延迟执行时间
    repL.instanceDelay = 0.5;
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    
    
}
//开始动画
- (void)start
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.repeatCount = MAXFLOAT;
    anim.path = self.path.CGPath;
    anim.duration = 5;
    [self.dotLayer addAnimation:anim forKey:nil];
}

- (void)redraw
{
 //删除动画
    [self.dotLayer removeAllAnimations];
    //删除路径
    [self.path removeAllPoints];
    [self setNeedsDisplay];
}



-(void)pann:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:self];
    if(pan.state == UIGestureRecognizerStateBegan){
        //移到起始点
      
        [self.path moveToPoint:curP];
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }
}


- (void)drawRect:(CGRect)rect
{
    //绘制路径
    [self.path stroke];
}

@end
