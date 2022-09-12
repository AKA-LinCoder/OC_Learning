//
//  watermarkVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "watermarkVC.h"
#import "UIImage+image.h"

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
    self.imageView.image = [UIImage imageWithBoder:10 color:[UIColor redColor] image:[UIImage imageNamed:@"people"]];
    [self.view addSubview:self.imageView];
}

//带有边框的圆形图片裁剪
-(UIImage *) imageWithBoder:(CGFloat)boderW color:(UIColor *)boderColor image:(UIImage *)image
{
    ///加载图片
//    UIImage *image = [UIImage imageNamed:@"people"];
    ///确定边框宽度
//    CGFloat boderW = 10;
    ///开启一个上下文
    CGSize size = CGSizeMake(image.size.width + 2*boderW, image.size.height + 2*boderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    ///绘制大圆，显示出来
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [boderColor set];
    [path fill];
    ///绘制一个小圆，把小圆设置为裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(boderW, boderW, image.size.width, image.size.height)];
    [clipPath addClip];
    ///把图片绘制到上下文中
    [image drawAtPoint:CGPointMake(boderW, boderW)];
    ///从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    ///关闭上下文
    UIGraphicsEndImageContext();
   
    
    return newImage;
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
