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
    [self setUpLongSwipe];
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
