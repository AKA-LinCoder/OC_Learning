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
@end
