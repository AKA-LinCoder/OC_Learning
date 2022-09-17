//
//  WheelView.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "WheelView.h"
#import "WheelBtn.h"

#define angle2Rad(angle)((angle)/180.0*M_PI)
@interface WheelView()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property(nonatomic,weak) WheelBtn *selectedBtn;
@property(nonatomic,strong) CADisplayLink *link;

@end

@implementation WheelView

- (CADisplayLink *)link
{
    if(_link == nil){
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    return _link;
}
+ (instancetype)wheelView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //添加转盘按钮
    CGFloat btnW = 65;
    CGFloat btnH = 143;
    CGFloat angle = 0;
    
    //加载原始大图
    UIImage *orilImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *orilSelImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat clipW = orilImage.size.width/12 *[UIScreen mainScreen].scale;
    CGFloat clipH = orilImage.size.height*[UIScreen mainScreen].scale;
    
    for(int i = 0;i<12;i++){
        UIButton *btn = [WheelBtn buttonWithType:UIButtonTypeCustom];
        btn.bounds =CGRectMake(0, 0, btnW, btnH);
        x = clipW * i;
        //设置按钮选中状态下背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        //裁剪的图片
        CGImageRef normalImage =  CGImageCreateWithImageInRect(orilImage.CGImage, CGRectMake(x, y, clipW, clipH));
        //设置按钮正常状态图片
        [btn setImage:[UIImage imageWithCGImage:normalImage] forState:UIControlStateNormal];
        
        //裁剪的图片
        //CGImageCreateWithImageInRect这是C语言的方法，以像素点坐标和iOS（点坐标）不一样
        CGImageRef selectedImage =  CGImageCreateWithImageInRect(orilSelImage.CGImage, CGRectMake(x, y, clipW, clipH));
        //设置按钮正常状态图片
        [btn setImage:[UIImage imageWithCGImage:selectedImage] forState:UIControlStateSelected];
    
        
        
        
        //设置按钮位置
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
//        btn.backgroundColor = [UIColor redColor];
        //每个按钮在旋转
        btn.transform = CGAffineTransformMakeRotation(angle2Rad(angle));
        angle += 30;
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView setUserInteractionEnabled: YES];
        [self.bgView addSubview:btn];
        //默认让第一个按钮成为选中状态
        if(i==0){
            [self btnClick:btn];
        }
        
    }
}

-(void)btnClick:(UIButton *)btn
{
    //让当前点击按钮成为选中状态
    
    //1.让当前选中按钮成为取消选中
    [self.selectedBtn setSelected:NO];
    //2.让当前点击按钮成为选中状态
    [btn setSelected:YES];
    //3.当前点击按钮成为选中按钮
    self.selectedBtn = btn;
}
- (void)startRotation
{
    //这是使用layer旋转，实际上位置那些都没有改变所以不能用这种方式，得使用UIView的动画
//    CABasicAnimation *anim = [CABasicAnimation animation];
//    //设置属性
//    anim.keyPath = @"transform.rotation";
//    anim.toValue = @(M_PI*3);
//    anim.duration = 1;
//    anim.repeatCount = MAXFLOAT;
//    //添加动画
//
//    [self.bgView.layer addAnimation:anim forKey:nil];
    //添加定时器，保持一直旋转
    self.link.paused = NO;
    
}
- (IBAction)startChoose:(id)sender {
    //让转盘快速的旋转几圈，当前旋转的按钮指向最上方
        CABasicAnimation *anim = [CABasicAnimation animation];
        //设置属性
        anim.keyPath = @"transform.rotation";
        anim.toValue = @(M_PI*4);
        anim.duration = 0.5;
        anim.delegate = self;
//        anim.repeatCount = MAXFLOAT;
        //添加动画
        [self.bgView.layer addAnimation:anim forKey:nil];
        //动画结束时旋转的按钮指向最上方
}

//非正式协议：给分类添加协议的方法
- (void)animationDidStart:(CAAnimation *)anim
{
    
}
//动画结束时调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //让当前选中按钮的父控件倒这旋转回去
    //当前按钮旋转的角度
    
    CGAffineTransform transform = self.selectedBtn.transform;
    //通过transform获取当前旋转的度数
    CGFloat angle =  atan2(transform.b,transform.a);
    self.bgView.transform = CGAffineTransformMakeRotation(-angle);
}



//让按钮真实旋转
-(void) update
{
    self.bgView.transform = CGAffineTransformRotate(self.bgView.transform, M_PI/200.0);
}

- (void)stopRotation
{
    self.link.paused = YES;
//    [self.bgView.layer removeAllAnimations];
}
@end
