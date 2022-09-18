//
//  BadgeValue.m
//  OC_Learning
//
//  Created by Estim on 2022/9/18.
//

#import "BadgeValue.h"

@interface BadgeValue()
@property(nonatomic,strong)UIView *smallCircle;
///记录小圆原始半径
@property(nonatomic,assign) CGFloat oWidth;
@end
@implementation BadgeValue

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    //添加收拾
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pann:)];
    [self addGestureRecognizer:pan];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        //添加收拾
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pann:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}


-(void) pann:(UIPanGestureRecognizer *)pan
{
    //拖动
    CGPoint transP =  [pan translationInView:self];
    //transform并没有修改center，它修改的是frame
//    self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    
    
    //重绘
    [pan setTranslation:CGPointZero inView:self];
    //获取两个圆心之间的距离
    CGFloat distance = [self distanceWithSmallCircle:self.smallCircle BigCircle:self];
    //根据距离变大将里面圆的半径减小
    CGFloat smallR =  self.oWidth * 0.5;
    smallR -= distance / 10.0;
    self.smallCircle.bounds = CGRectMake(0, 0, smallR *2, smallR *2);
    self.smallCircle.layer.cornerRadius = smallR;
    
}


-(void)setup
{
    //设置圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    //背景颜色
    self.backgroundColor = [UIColor redColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    //添加小圆
    UIView *smallCircle = [[UIView alloc] initWithFrame:self.frame];
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    smallCircle.backgroundColor = self.backgroundColor;
    self.smallCircle = smallCircle;
    self.oWidth =  self.smallCircle.bounds.size.width;
    //把一个view添加到指定位置
    [self.superview insertSubview:smallCircle belowSubview:self];
}
//求两个圆的距离
-(CGFloat) distanceWithSmallCircle:(UIView *)smallCircle BigCircle:(UIView *)bigCircle
{
    //X轴偏移量
    CGFloat offetX = bigCircle.center.x - smallCircle.center.x;
    //Y轴偏移量
    CGFloat offetY = bigCircle.center.y - smallCircle.center.y;
    
    return sqrt(offetX*offetX+offetY*offetY);
}


//重写方法，取消高亮
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
