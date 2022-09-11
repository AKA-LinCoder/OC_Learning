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
    UIImage *image = [UIImage imageNamed:@"people"];
    //绘制原始图片大小
//    [image drawAtPoint:CGPointZero];
    //把绘制的图片填充到给定的view中
//    [image drawInRect:rect];
    //裁剪(超过裁剪区域的不会显示)，裁剪一定要在绘制之前进行设置
    UIRectClip(CGRectMake(0, 0, 50, 50));
    
    
    //平铺 图片小会有很多
    [image drawAsPatternInRect:rect];
    
    
    //快速绘制矩形
//    UIRectClip(CGRectMake(0, 0, 50, 50));
    
}
//不通过UIlable绘制文字
-(void) drawString:(CGRect)rect
{
    //
    NSString *str = @"林冠宇";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //字体颜色
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:40];
    //文字颜色
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    //描边
    dict[NSStrokeWidthAttributeName] = @2;
    dict[ NSStrokeColorAttributeName] = [UIColor greenColor];
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor orangeColor];
    //设置阴影偏移量
    shadow.shadowOffset = CGSizeMake(10, 10);
    shadow.shadowBlurRadius = 3;
    dict[NSShadowAttributeName] = shadow;
    //不会自动换行
//    [str drawAtPoint:CGPointZero withAttributes:dict];
    //会自动换行
    [str drawInRect:rect withAttributes:dict];
}

-(void) drawPie2:(CGRect)rect
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
