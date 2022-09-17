//
//  ImageFoldVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "ImageFoldVC.h"

@interface ImageFoldVC ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;
@property(nonatomic,weak)  CAGradientLayer *grandientL;

@end

@implementation ImageFoldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //让上面图片只显示上面，下面图片只显示下面
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 0);
    
    //渐变层
    CAGradientLayer *grandientL = [CAGradientLayer layer];
    grandientL.frame = self.bottomImageV.bounds;
   
    //渐变颜色
    grandientL.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    //设置渐变透明
    grandientL.opacity = 0;
    
    
    //设置一个渐变到另一个渐变的起始位置
    grandientL.locations= @[@0.3,@0.5];
    self.grandientL = grandientL;
    [self.bottomImageV.layer addSublayer:grandientL];
    

}

-(void)grandientLayer
{
    //渐变层
    CAGradientLayer *grandientL = [CAGradientLayer layer];
    grandientL.frame = self.bottomImageV.bounds;
    //渐变方向
    grandientL.startPoint = CGPointMake(0, 0);
    grandientL.endPoint = CGPointMake(1, 0);
    //渐变颜色
    grandientL.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    //设置一个渐变到另一个渐变的起始位置
    grandientL.locations= @[@0.3,@0.5];
    
    [self.bottomImageV.layer addSublayer:grandientL];
}


- (IBAction)pann:(UIPanGestureRecognizer *)pan {
    //获取移动的偏移量
    CGPoint transP =  [pan translationInView:pan.view];
    //上图旋转角度
    CGFloat angle = transP.y*M_PI /200.0;
    
    //近大远小效果
    CATransform3D trans = CATransform3DIdentity;
    //眼睛离屏幕距离
    trans.m34 = -1/500.0;
    
    self.grandientL.opacity = transP.y * 1/ 200.0;
    
    self.topImageV.layer.transform = CATransform3DRotate(trans, -angle, 1, 0, 0);
    
    //当停止拖动时进行复位操作
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.grandientL.opacity = NO;
        //上部图片复位
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0  options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                } completion:^(BOOL finished) {
                    self.topImageV.layer.transform = CATransform3DIdentity;
                  
                }];
       
    }
    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.topImageV.layer.transform = CATransform3DRotate(self.topImageV.layer.transform, M_PI, 1, 0, 0);
//    }];
}



@end
