//
//  processView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "processView.h"

@interface processView()

@end

@implementation processView
- (UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        _label.text = @"0.0%";
        _label.center = self.center;
        _label.backgroundColor = [UIColor orangeColor];
        _label.tintColor = [UIColor blackColor];
        _label.numberOfLines = 1;
        [_label sizeToFit];
        
        
        
    }
    return  _label;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.label];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
  
    //画圆
    CGPoint center = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    CGFloat radius = rect.size.width *0.5 - 10;
    CGFloat startA = -M_PI_2;
    CGFloat endA =  startA + self.value*1 * M_PI*2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
}

- (void)setValue:(CGFloat)value
{
    _value = value;
    //drawRect如果是手动调用的话，它是不会给你创建上下文的
    //只有系统调用该方法是，才会创建跟view相关的上下文
//    [self drawRect:self.bounds];
    
    //重绘,系统自动调drawrect
    [self setNeedsDisplay];
}


@end
