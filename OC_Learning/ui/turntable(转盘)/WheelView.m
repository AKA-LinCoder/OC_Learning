//
//  WheelView.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "WheelView.h"
#import "WheelBtn.h"

#define angle2Rad(angle)((angle)/180.0*M_PI)
@interface WheelView()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property(nonatomic,weak) WheelBtn *selectedBtn;

@end

@implementation WheelView

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
    for(int i = 0;i<12;i++){
        UIButton *btn = [WheelBtn buttonWithType:UIButtonTypeCustom];
        btn.bounds =CGRectMake(0, 0, btnW, btnH);
        
        //设置按钮选中状态下图片
        [btn setImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        
        
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
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置属性
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI*3);
    anim.duration = 1;
    anim.repeatCount = MAXFLOAT;
    //添加动画
    
    [self.bgView.layer addAnimation:anim forKey:nil];
}

- (void)stopRotation
{
    [self.bgView.layer removeAllAnimations];
}
@end
