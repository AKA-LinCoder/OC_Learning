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

}


- (IBAction)pann:(UIPanGestureRecognizer *)pan {
    NSLog(@"%s",__func__);
    //获取移动的偏移量
    CGPoint transP =  [pan translationInView:pan.view];
    //上图旋转角度
    CGFloat angle = transP.y*M_PI /200.0;
    
    //近大远小效果
    CATransform3D trans = CATransform3DIdentity;
    //眼睛离屏幕距离
    trans.m34 = -1/500.0;
    self.topImageV.layer.transform = CATransform3DRotate(trans, -angle, 1, 0, 0);
    
    
    
    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.topImageV.layer.transform = CATransform3DRotate(self.topImageV.layer.transform, M_PI, 1, 0, 0);
//    }];
}



@end
