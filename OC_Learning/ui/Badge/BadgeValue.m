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
@property(nonatomic,strong) CAShapeLayer *shapeL;
@end
@implementation BadgeValue
- (CAShapeLayer *)shapeL
{
    if(_shapeL==nil){
        CAShapeLayer *shapL = [CAShapeLayer layer];
        [self.superview.layer insertSublayer:shapL atIndex:0];
        shapL.fillColor = [UIColor redColor].CGColor;
        _shapeL = shapL;
    }
    return _shapeL;
}
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
        //添加手势
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
    
    UIBezierPath *path = [self pathWithSmallCircle:self.smallCircle BigCircle:self];
    if (self.smallCircle.hidden == NO) {
        //形状图层
        self.shapeL.path = path.CGPath;
    }
    if (distance>60) {
        //让小圆隐藏，让路径隐藏
        self.smallCircle.hidden = YES;
        //直接隐藏会有隐式动画的影响
//        self.shapeL.hidden = YES;
        [self.shapeL removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //
        if(distance>60){
            //播放动画，按钮消失
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            NSMutableArray *array = [NSMutableArray array];
            for(int i = 0; i< 8; i++){
                UIImage *img =  [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
                [array addObject:img];
            }
            imageV.animationDuration = 1;
            imageV.animationImages = array;
            [imageV startAnimating];
            
            [self addSubview:imageV];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
            
        }else{
            //复位
            [UIView animateWithDuration:0.5 animations:^{
                            [self.shapeL removeFromSuperlayer];
                            self.center = self.smallCircle.center;
                self.smallCircle.hidden = NO;
            }];
        }
    }
    
    
}
//给定两个圆，描述一个不规则的路径
-(UIBezierPath *) pathWithSmallCircle:(UIView *)smallCircle BigCircle:(UIView *)bigCircle
{
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle BigCircle:bigCircle];
    
    if (d <= 0) {
        return nil;
    }
    
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    
    return path;
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
