//
//  CALayerVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "CALayerVC.h"

@interface CALayerVC ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property(weak,nonatomic) CALayer *layer;

@end

@implementation CALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView之所以能显示在屏幕上，完全是因为它内部的CALayer
    
    
    //手动创建layer
    CALayer *layer = [[CALayer alloc] init];
//    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [[UIColor redColor] CGColor];
    layer.frame = CGRectMake(300, 300, 100, 100);
    [self.view.layer addSublayer:layer];
    layer.contents = (id)[UIImage imageNamed:@"people"].CGImage;
    
    
    
    CALayer *oneLayer = [CALayer layer];
    oneLayer.bounds = CGRectMake(0, 0, 100, 100);
    oneLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    self.layer = oneLayer;
    //默认anchorPoint为（0.5，0.5）,所以会只显示了1/4
//
    [self.view.layer addSublayer:oneLayer];
    
    
    /*
     CALayer是定义在QuartzCore框架中（可在手机电脑使用）
     CGImageRef,CGColorRef两种数据类型是定义在CoreGraphics框架中（可在手机电脑使用）
     UIColor，UIImage是定义在UIKit框架中（可在手机使用）
     所以layer为了保证可移植性，得使用CG那些东西
     */
    
    /*
     对比CALayer（性能高）,UIView，UIview因为继承了UIResponder可以处理事件，所以当需要和用户进行交互时得选择UIView,只显示的话，两者皆可；为避免需求变更，尽量使用uiview
     */
    
    /*
     position和anchorPoint
     position:用来设置CALayer在父层中的位置，以父层的左上角为原点
     anchorPotion：定位点，锚点；决定CALayer身上哪个点会在positio
 属性所指的位置，以自己的左上角为原点， x,y取值范围都是0-1，默认都是0.5     */
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
[self imageViewLayer];
    self.layer.position = self.view.center;
    self.layer.anchorPoint = CGPointMake(0, 0);
    //position和anchorPoint始终重合
    //UIViewde center和position是一个东西
 
}

-(void)imageViewLayer
{
    self.imageV.layer.shadowColor = [[UIColor greenColor] CGColor];
    //模糊半径
    self.imageV.layer.shadowRadius = 10;
    //设置阴影的不透明度,设置阴影必须先将此属性为1
    self.imageV.layer.shadowOpacity = 1;
    self.imageV.layer.shadowOffset = CGSizeMake(20, 20);
    //设置边框宽度，往里面走
    self.imageV.layer.borderWidth = 10;
    self.imageV.layer.borderColor = [[UIColor orangeColor] CGColor];
    
    /*
     以上操作是直接操作layer的，无法操作layer内部的东西
     */
    
    
    
    //设置圆角没有作用
    //imageView中的image并不是直接添加到layer上的，而是添加到layer内部的contents上
    self.imageV.layer.cornerRadius = 50;
    //把超过根层以外的东西都裁剪掉(UIView自带的层，叫做根层)
    self.imageV.layer.masksToBounds = YES;
   
    //3D效果
    [UIView animateWithDuration:0.5 animations:^{
        //方法1
//        self.imageV.layer.transform = CATransform3DRotate(self.imageV.layer.transform, M_PI, 1, 1, 0);
//        //方法2:通过KVC设置
//        NSValue *value =  [NSValue valueWithCATransform3D:CATransform3DRotate(self.imageV.layer.transform, M_PI, 1, 1, 0)];
//        [self.imageV.layer setValue:value forKey:@"transform"];
        //通过KVC一般进行快速选择，平移，缩放操作
        [self.imageV.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.y"];
        //缩放
        [self.imageV.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
        //平移
        [self.imageV.layer setValue:@(100) forKeyPath:@"transform.translation.x"];
        
    }];
    
}

-(void)uiviewLayer
{
    self.redView.layer.shadowColor = [[UIColor greenColor] CGColor];
    //模糊半径
    self.redView.layer.shadowRadius = 10;
    //设置阴影的不透明度,设置阴影必须先将此属性为1
    self.redView.layer.shadowOpacity = 1;
    self.redView.layer.shadowOffset = CGSizeMake(20, 20);
    //设置边框宽度，往里面走
    self.redView.layer.borderWidth = 10;
    self.redView.layer.borderColor = [[UIColor orangeColor] CGColor];
    //设置圆角
    self.redView.layer.cornerRadius = 30;
}
@end
