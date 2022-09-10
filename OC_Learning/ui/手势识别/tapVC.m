//
//  tapVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/10.
//

#import "tapVC.h"

@interface tapVC ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation tapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建手势
    [self setUpPinch];
}
//是否允许同时接收多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


//旋转手势
-(void) setUpRotaion
{
    UIRotationGestureRecognizer *tap = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotaions:)];
    self.imageView.userInteractionEnabled = YES;
    //要想同时支持多个手势，必须用代理
    tap.delegate = self;
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}
//缩放手势
-(void) setUpPinch
{
    UIPinchGestureRecognizer *tap = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    self.imageView.userInteractionEnabled = YES;
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}


//拖动手势
-(void) setUpPan
{
    /// 当长按时调用(当长按时，该方法会持续调用)
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    //设置轻扫手势方法，一个轻扫手势只能对应一个手势
//    tap.direction =
    self.imageView.userInteractionEnabled = YES;
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}

//轻扫手势
-(void) setUpLongSwipe
{
    /// 当长按时调用(当长按时，该方法会持续调用)
    UISwipeGestureRecognizer *tap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    //设置轻扫手势方法，一个轻扫手势只能对应一个手势
//    tap.direction =
    self.imageView.userInteractionEnabled = YES;
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}


-(void) setUpLongTap
{
    /// 当长按时调用(当长按时，该方法会持续调用)
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapp:)];
    self.imageView.userInteractionEnabled = YES;
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}

-(void) setUPTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapp)];
    self.imageView.userInteractionEnabled = YES;
    //添加手势
    [self.imageView addGestureRecognizer:tap];
    tap.delegate = self;
}


//手势方法
-(void) tapp
{
    NSLog(@"%s",__func__);
}

-(void) longTapp:(UILongPressGestureRecognizer *)tapp
{
    NSLog(@"%s",__func__);
    //判断手势的状态
    if (tapp.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
    }else if (tapp.state == UIGestureRecognizerStateChanged){
        NSLog(@"开始移动");
    }else if (tapp.state == UIGestureRecognizerStateEnded){
        NSLog(@"结束移动");
    }else{
        NSLog(@"开始长按");
    }
}

-(void) swipe
{
    NSLog(@"%s",__func__);
}

-(void) pan:(UIPanGestureRecognizer *)pann
{
    NSLog(@"%s",__func__);
    //获取相对于最原始的偏移量
    CGPoint transP =  [pann translationInView:self.imageView];
    //如果直接使用，会导致跳动距离太大
    self.imageView .transform = CGAffineTransformTranslate(self.imageView.transform, transP.x, transP.y);
    //让它相对于上一次，复位
    [pann setTranslation:CGPointZero inView:self.imageView];
}
//缩放时调用
-(void) pinch:(UIPinchGestureRecognizer *)pinch
{
    NSLog(@"%s",__func__);
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    //复位
    [pinch setScale:1];
}

//旋转时调用
-(void) rotations:(UIRotationGestureRecognizer *)rotationGes
{
    NSLog(@"%s",__func__);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotationGes.rotation);
    //复位
    [rotationGes setRotation:0];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //让左边图片不能惦记，右边能够点击
    
    //获取当前手指的点
    CGPoint point = [touch locationInView:self.imageView];
    //判断点在左边还是右边
    if (point.x > self.imageView.frame.size.width * 0.5) {
        return YES;
    }
    return NO;
}

@end
