//
//  DrawView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "DrawView.h"

@implementation DrawView



/// 专门用来绘图使用
/// 什么时候调用：当view显示的时候调用，viewwillappear之后，viewdidAppear之前
/// @param rect 当前view的尺寸bounds
- (void)drawRect:(CGRect)rect {
    //在此方法中，系统已经创建了一个跟view相关联的上下文(Layer上下文)
    [self drawCurve:CGPointMake(20, 20) endPoint:CGPointMake(30, 100)];
    

    
    
}


/// 绘制线
/// @param startPoint 起点
/// @param endPoint 终点
-(void) drawLine:(CGPoint) startPoint endPoint:(CGPoint) endPoint
{
    //1.获取上下文
    CGContextRef context =  UIGraphicsGetCurrentContext();
    
    //上下文状态
    //线宽
    CGContextSetLineWidth(context, 10);
    //设置线的连接样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //设置线顶角样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置颜色
    [[UIColor redColor] set];
    
    
    //2.绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.1设置起点
    [path moveToPoint:startPoint];
    //2.2添加一根线到终点
    [path addLineToPoint:endPoint];
    
    
    //画第二条线
//    [path moveToPoint:startPoint];
//    [path addLineToPoint:endPoint];
    //把上一条线的终点当作是下一条线的终点
//    [path addLineToPoint:endPoint];
    
    
    
    //3.把绘制的内容，保存到上下文中
    CGContextAddPath(context, path.CGPath);
    //4.把上下文的内容显示到view的layer上(stoke 描边 fill 填充)
    CGContextStrokePath(context);
}


-(void) drawCurve:(CGPoint) startPoint endPoint:(CGPoint) endPoint
{
    //1.获取上下文
    CGContextRef context =  UIGraphicsGetCurrentContext();
    
    //2.绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //画曲线
    //设置起点
    [path moveToPoint:startPoint];
    //添加一个曲线到某一个点
    [path addQuadCurveToPoint:endPoint controlPoint:CGPointMake(50, 50)];
    //3.把绘制的内容，保存到上下文中
    CGContextAddPath(context, path.CGPath);
    //4.把上下文的内容显示到view的layer上(stoke 描边 fill 填充)
    CGContextStrokePath(context);
}

@end
