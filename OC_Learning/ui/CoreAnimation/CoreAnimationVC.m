//
//  CoreAnimationVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "CoreAnimationVC.h"

#define angle2Rad(angle)((angle) / 180.0 * M_PI)
@interface CoreAnimationVC ()
@property(nonatomic,strong) UIView *redView;
@property(nonatomic,strong) UIImageView *imageV;
@end

@implementation CoreAnimationVC
- (UIImageView *)imageV
{
    if(_imageV == nil){
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _imageV.image = [UIImage imageNamed:@"heart"];
    }
    return _imageV;
}
- (UIView *)redView
{
    if (_redView==nil) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _redView.center = self.view.center;
        _redView.backgroundColor = [UIColor redColor];
    }
    return  _redView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.imageV];
    /*
     CoreAnimation是直接作用在CALayer上的，并非UIView
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建动画对象
    CABasicAnimation *basicA = [CABasicAnimation animation];
    //设置属性值
    basicA.keyPath = @"position.x";
    basicA.toValue = @300;
//    //动画完成时，会自动删除动画
//    basicA.removedOnCompletion = NO;
//    //默认是最后，因为动画默认经过了 A->B->A
//    basicA.fillMode = kCAFillModeForwards;
//    //添加动画
//    [self.redView.layer addAnimation:basicA forKey:@"basicA"];
    
    //创建对象
    CABasicAnimation *basicB = [CABasicAnimation animation];
    //设置对象属性
    basicB.keyPath = @"transform.scale";
    basicB.toValue = @0;
    //重复
    basicB.repeatCount = MAXFLOAT;
    //设置动画执行时长
    basicB.duration = 0.5;
    //自动翻转：怎么样去，怎么样回来
    basicB.autoreverses = YES;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicA,basicB];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    //添加动画
    [self.imageV.layer addAnimation:group forKey:@"basicB"];
    
    
    [self iconshake];
    
    [self iconPath];
    [self changeImageByAnimation];
  
}
//转场动画
-(void) changeImageByAnimation
{
    
   
    //转场动画和转场代码必须在一个方法中
    self.imageV.image = [UIImage imageNamed:@"小孩"];
    //添加转场动画
    CATransition *anim = [CATransition animation];
    anim.type = @"pageCurl";
    //0是右下角
    anim.startProgress = 0;
    anim.endProgress = 1;
    [self.imageV.layer addAnimation:anim forKey:nil];
}

//图片沿路径走
-(void) iconPath
{
    CAKeyframeAnimation *key2 = [CAKeyframeAnimation animation];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(10, 40)];
    [path addLineToPoint:CGPointMake(130, 440)];
    key2.keyPath = @"position.x";
    key2.path = path.CGPath;
    key2.duration = 2;
    [self.redView.layer addAnimation:key2 forKey:nil];
}

//图片抖动
-(void) iconshake
{
    //帧动画
    //创建动画对象
    CAKeyframeAnimation *key1 = [CAKeyframeAnimation animation];
    key1.keyPath = @"transform.rotation";
    key1.values = @[@angle2Rad(-5),@angle2Rad(5)];
    key1.repeatCount = MAXFLOAT;
    key1.duration = 0.5;
    key1.autoreverses = YES;
    [self.redView.layer addAnimation:key1 forKey:nil];
}

@end
