//
//  screenshootVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "screenshootVC.h"

@interface screenshootVC ()

@end

@implementation screenshootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //开启一个位图上下文(跟当前控制器view一样大小的尺寸)
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    //把控制器的view绘制到上下文中。必须使用渲染
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    //从当前上下文中生成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    //把生成的图片写入到桌面(以文件方式进行传输：二进制流)
    //1原始质量
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    //写入桌面
    [data writeToFile:@"/Users/lsaac/Desktop/to/newImage.jpg" atomically:YES];
    
    
    
}

@end
