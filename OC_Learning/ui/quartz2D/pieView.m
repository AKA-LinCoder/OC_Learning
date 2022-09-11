//
//  pieView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "pieView.h"

@implementation pieView

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width*0.5,rect.size.height*0.5 );
    CGFloat radius = rect.size.width*0.5-10;
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = startA+angle;
    NSArray *dataArray = @[@25,@25,@50];
    for (NSNumber *num in dataArray) {
        startA = endA;
        angle = (num.intValue)/100.0*M_PI*2;
        endA = startA + angle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [[self randomColor] set];
        //添加一根线到圆形
        [path addLineToPoint:center];
        [path fill];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //重绘
    [self setNeedsDisplay];
}

//随机生成颜色
-(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

-(void) drawPie1:(CGRect)rect
{
    //画第一个扇形
    CGPoint center = CGPointMake(rect.size.width*0.5,rect.size.height*0.5 );
    CGFloat radius = rect.size.width*0.5-10;
    CGFloat startA = 0;
    CGFloat angle = 25/100.0 *M_PI*2;
    CGFloat endA = startA+angle;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [[UIColor redColor] set];
    //添加一根线到圆形
    [path addLineToPoint:center];
    [path fill];
    //画第二个扇形
    startA = endA;
    endA = startA + angle;
    path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [[UIColor orangeColor] set];
    //添加一根线到圆形
    [path addLineToPoint:center];
    [path fill];
    //画第三个扇形
    startA = endA;
    angle = 50/100.0*M_PI*2;
    endA = startA + angle;
    path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [[UIColor blueColor] set];
    //添加一根线到圆形
    [path addLineToPoint:center];
    [path fill];
}

@end
