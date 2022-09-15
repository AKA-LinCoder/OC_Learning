//
//  ClockVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "ClockVC.h"


#define angle2Rad(angle)((angle)/180.0*M_PI)

@interface ClockVC ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;
@property(nonatomic,weak)CALayer *secL;
@property(nonatomic,weak)CALayer *minL;
@property(nonatomic,weak)CALayer *hourL;
@end

@implementation ClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加时针
    [self setHour];
    //添加分针
    [self setMin];
    //添加秒针
    [self setSec];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
    
}

-(void)timeChange
{
    //计算秒针旋转角度
    
    //当前秒
    NSCalendar *cal = [NSCalendar currentCalendar];
    //从什么时间获取
    NSDateComponents *cmp =  [cal components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour fromDate:[NSDate date]];
    
    /*
     秒针：1秒转6度
        1分钟转6度
     1小时转30度
     */
    //angle = 当前多少秒*每一秒旋转多少度
    CGFloat secAngle = cmp.second *M_PI/30;
    //angle = 当前多少分*每一分旋转多少度
    CGFloat minAngle = cmp.minute *M_PI/30;
    //angle = 当前多少小时*每一小时旋转多少度
    //还需要加上每一分时针旋转的角度0.5度
    CGFloat hourAngle = cmp.hour *M_PI/6+(M_PI/360)*cmp.minute;
    
    self.secL.transform = CATransform3DMakeRotation(secAngle, 0, 0, 1);
    
    self.minL.transform = CATransform3DMakeRotation(minAngle, 0, 0, 1);
    self.hourL.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1);
    
    
//
//    self.secL.transform = CATransform3DRotate(self.secL.transform, M_PI/30.0, 0, 0, 1);
}

-(void) setSec
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 3, 90);
    layer.backgroundColor = [[UIColor redColor] CGColor];
    //因为旋转缩放都是绕锚点进行的，所以修改锚点所在位置
    layer.anchorPoint = CGPointMake(0.5, 1);
    //让时针在表盘中心
    layer.position = CGPointMake(self.clockView.bounds.size.width*0.5, self.clockView.bounds.size.height*0.5);
    [self.clockView.layer addSublayer:layer];
    self.secL = layer;
}


-(void) setMin
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 5, 90);
    layer.backgroundColor = [[UIColor blackColor] CGColor];
    //因为旋转缩放都是绕锚点进行的，所以修改锚点所在位置
    layer.anchorPoint = CGPointMake(0.5, 1);
    //让时针在表盘中心
    layer.position = CGPointMake(self.clockView.bounds.size.width*0.5, self.clockView.bounds.size.height*0.5);
    [self.clockView.layer addSublayer:layer];
    self.minL = layer;
}


- (void)setHour
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 5, 90);
    layer.backgroundColor = [[UIColor blueColor] CGColor];
    //因为旋转缩放都是绕锚点进行的，所以修改锚点所在位置
    layer.anchorPoint = CGPointMake(0.5, 1);
    //让时针在表盘中心
    layer.position = CGPointMake(self.clockView.bounds.size.width*0.5, self.clockView.bounds.size.height*0.5);
    [self.clockView.layer addSublayer:layer];
    self.hourL = layer;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    //有时顺时针有时逆时针(路径一致默认逆时针)：走的最短路径
//    //所有的旋转和缩放都是绕着锚点进行
//    self.secL.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
//}

@end
