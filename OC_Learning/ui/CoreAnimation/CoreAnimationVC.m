//
//  CoreAnimationVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "CoreAnimationVC.h"

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
    //动画完成时，会自动删除动画
    basicA.removedOnCompletion = NO;
    //默认是最后，因为动画默认经过了 A->B->A
    basicA.fillMode = kCAFillModeForwards;
    //添加动画
    [self.redView.layer addAnimation:basicA forKey:@"basicA"];
    
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
    //添加动画
    [self.imageV.layer addAnimation:basicB forKey:@"basicB"];
    
}


@end
