//
//  SizeAndCenterVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "SizeAndCenterVC.h"

@interface SizeAndCenterVC ()

@end

@implementation SizeAndCenterVC
/*
 frame,bounds
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
  
    
   
//    view.bounds = CGRectMake(0, 0, 200, 200);
    view.center = self.view.center;
    CGRect frame = view.frame;
    frame.size = CGSizeMake( 200, 200);
    view.frame = frame; //frame是从左上角开始绘制，所以center会以为是起点
    //bounds是从中心点绘制，所以不会存在这种问题
    //先设置center再设置size，使用frame就会有问题
    //如果size是从bounds取出来，就不用考虑center和size
    //如果size是从frame取出来，先设置size再设置center
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
}



@end
