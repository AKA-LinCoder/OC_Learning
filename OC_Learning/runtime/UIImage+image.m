//
//  UIImage+image.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "UIImage+image.h"
#import <objc/message.h>

@implementation UIImage (image)
//把类加载到内存的时候调用，只会调用一次
+ (void)load
{
    Method imageNamedMethod =  class_getClassMethod(self, @selector(imageNamed:));
    Method lin_imageNamedMethod = class_getClassMethod(self, @selector(lin_imageNamed:));
    //交换方法
    method_exchangeImplementations(imageNamedMethod, lin_imageNamedMethod);
}
//会调用多次
+ (void)initialize
{
    //也可以这样实现只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

//1.加载图片
//2.判断图片是否加载成功
+ (UIImage *)lin_imageNamed:(NSString *)name
{
    UIImage *image = [UIImage lin_imageNamed:name];
    if (image) {
        NSLog(@"加载成功");
    }else{
        NSLog(@"加载失败");
    }
    return  image;
}
@end
