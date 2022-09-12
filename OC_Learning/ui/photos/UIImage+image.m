//
//  UIImage+image.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+(UIImage *) imageWithBoder:(CGFloat)boderW color:(UIColor *)boderColor image:(UIImage *)image
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
@end
