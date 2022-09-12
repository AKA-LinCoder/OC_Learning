//
//  watermarkVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "watermarkVC.h"

@interface watermarkVC ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation watermarkVC
- (UIImageView *)imageView
{
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
        _imageView.center = self.view.center;
    }
    return _imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载图片
    UIImage *image = [UIImage imageNamed:@"people"];
    //开启一个跟图片原始大小的上下文
    //opaque不透明,yes 透明 no
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //把图片绘制到上下文中
    [image drawAtPoint:CGPointZero];
    //把文字绘制到上下文中
    NSString *str = @"林冠宇";
    [str drawAtPoint:CGPointMake(10, 20) withAttributes:nil];
    //从上下文中生成一张图片，把上下文中所有内容生成一张图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
//    self.imageView.image = newImage;
    self.imageView.image = [self cropPhoto];
    [self.view addSubview:self.imageView];
}


/// 裁剪图片
-(UIImage *)cropPhoto
{
    UIImage *image = [UIImage imageNamed:@"people"];
    //开启图片上下文
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
   
    
    //设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //把圆形路径设置为裁剪区域
    [path addClip];
    //将图片添加到上下文中
    [image drawAtPoint:CGPointZero];
    //从当前上下文中生成新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    return newImage;
}


@end
