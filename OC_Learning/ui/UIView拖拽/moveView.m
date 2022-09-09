//
//  moveView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "moveView.h"

@implementation moveView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
/*
 NSSet:无序
 NSAray:有序
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s",__func__);
    //偏移量= 手指当前点的x-手指上一个点的x
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    CGPoint preP = [touch previousLocationInView:self];
    CGFloat offsetX = curP.x-preP.x;
    CGFloat offsetY = curP.y-preP.y;
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}

//UIApplication->window->view


//作用：去寻找最适合的view
//当一个事件传递给当前view时调用
//返回的是谁，谁就是最适合的view
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return  [super hitTest:point withEvent:event];;
}

//判断当前点在不在它调用view,(谁调用pointInside，这个view就是谁),触摸点在不在自己身上
//在hitTest中调用
//注意：point点必须得要和它方法调用者在同一个坐标系中
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super pointInside:point
                    withEvent:event];
}
@end
