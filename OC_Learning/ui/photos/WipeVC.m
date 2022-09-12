//
//  WipeVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "WipeVC.h"

@interface WipeVC ()
@property(nonatomic,strong)UIImageView *outImageView;
@property(nonatomic,strong)UIImageView *insideImageView;
@end

@implementation WipeVC
- (UIImageView *)outImageView
{
    if (_outImageView==nil) {
        _outImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _outImageView.image = [UIImage imageNamed:@"2A"];
    }
    return _outImageView;
}

- (UIImageView *)insideImageView
{
    if(_insideImageView==nil)
    {
        _insideImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _insideImageView.image = [UIImage imageNamed:@"2B"];
    }
    return  _insideImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.insideImageView];
    [self.view addSubview:self.outImageView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wiap:)];
    self.outImageView.userInteractionEnabled = YES;
    [self.outImageView addGestureRecognizer:pan];
}

-(void)wiap:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:self.outImageView];
    //确定擦出区域
    CGFloat rectWH = 10;
    CGFloat x = curP.x - rectWH*0.5;
    CGFloat y = curP.y - rectWH*0.5;
    CGRect rect = CGRectMake(x, y, rectWH, rectWH);
    //生成一张带有透明擦除区域的图片
  
    UIGraphicsBeginImageContextWithOptions(self.outImageView.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把UIImageView渲染到上下文
    [self.outImageView.layer renderInContext:context];
    //擦除上下文中指定区域
    CGContextClearRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.outImageView.image = newImage;
}

@end
