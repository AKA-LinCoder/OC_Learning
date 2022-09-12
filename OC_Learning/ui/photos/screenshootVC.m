//
//  screenshootVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "screenshootVC.h"

@interface screenshootVC ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,assign)CGPoint startP;
@property(nonatomic,assign)CGPoint curP;
@property(nonatomic,strong)UIView *coverView;
@end

@implementation screenshootVC
//保证只有一份，什么时候用什么时候才去加载
- (UIView *)coverView
{
    if (_coverView == nil) {
        UIView *coverView = [UIView new];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.7;
        _coverView = coverView;
        [self.view addSubview:coverView];
    }
    return _coverView;
}

- (UIImageView *)imageView
{
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imageView.image = [UIImage imageNamed:@"people"];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(photoShoot:)];
    [self.view addGestureRecognizer:pan];
}

-(void) photoShoot:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:self.view];
    //判断手势状态
    if(pan.state == UIGestureRecognizerStateBegan){
        self.startP = curP;
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGFloat x = self.startP.x;
        CGFloat y = self.startP.y;
        CGFloat w = curP.x-self.startP.x;
        CGFloat h = curP.y-self.startP.y;
        CGRect rect = CGRectMake(x, y, w, h);
        
        //添加UIview
        self.coverView.frame = rect;
        
    }else if (pan.state == UIGestureRecognizerStateEnded){
        //把超过区域的部分裁剪掉
        //生成一张图片，把原来的图片替换掉
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
        //把ImageV绘制到上下文之前，设置一个裁剪区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:self.coverView.frame];
        [clipPath addClip];
        //把当前imageview渲染到上下文中
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.imageView.layer renderInContext:context];
        //从上下文中生成图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        //移除遮盖
        [self.coverView removeFromSuperview];
        
        self.imageView.image = newImage;
    }
}

//截屏
-(void)screenshoot
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    
    
}

@end
