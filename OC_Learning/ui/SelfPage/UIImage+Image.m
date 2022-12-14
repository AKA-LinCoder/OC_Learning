//
//  UIImage+Image.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+(UIImage *) imageWithColor:(UIColor *)color
{
    //描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //渲染上希望
    CGContextFillRect(context, rect);
    //从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return  theImage;
}
@end
