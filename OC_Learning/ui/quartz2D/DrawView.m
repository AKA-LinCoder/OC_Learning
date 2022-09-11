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
//    [self drawCurve:CGPointMake(20, 20) endPoint:CGPointMake(30, 100)];
//    [self drawRectangle];
    [self drawCircul:rect];

    
    
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

//画曲线
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

//画矩形
-(void) drawRectangle
{
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 20)];
    //画圆角矩形,当radius为宽度的一半时就是圆
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 40, 40) cornerRadius:20];
    [[UIColor blueColor] set];
    //把路径添加到上下文
    CGContextAddPath(context, path1.CGPath);
    //渲染
//    CGContextStrokePath(context);
    CGContextFillPath(context);
    
}

//画圆
-(void) drawCircul:(CGRect)rect
{

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 50, 50)];
    //画弧
    //ArcCenter 弧所在的圆心
    //radius 半径
    //startAngle 开始弧度
    //endAngle 截止弧度
    //clockwise yes顺时针 no 逆时针
    //为什么不能直接使用self.center，因为self.center时相对于他的父控件
    CGPoint center = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:20 startAngle:0 endAngle:-M_PI_4 clockwise:NO];
//    [path1 setLineWidth:10];
    //画扇形
    //添加一根线到圆心
    [path1 addLineToPoint:center];
    //关闭路径，从路径中带你链接一根线到路径的起点
    [path1 closePath];
    //使用fill，会自动关闭路径
    [path1 stroke];
    //只能在drawRect里面才能获取到上下文
    
    //获取上下文->描述路径->把路径添加到上下文->将上下文的内容渲染到view上
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddPath(context, path.CGPath);
//    CGContextStrokePath(context);
   
}

@end
