//
//  greenView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "greenView.h"

@implementation greenView

//自己实现
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
   /*
    1.判断自己能否接收事件
    2.判断当前点在不在当前view
    3.从后往前遍历自己的子控件，让子控件重复前两步操作(把事件传递给子控件)
    */
    //1
    if(self.userInteractionEnabled == NO || self.isHidden == YES ||self.alpha<=0.01){
        return nil;
    }
    //2
    if(![self pointInside:point withEvent:event]){
        return nil;
    }
    //3
    int count = (int)self.subviews.count;
    for (int i = count-1; i>=0; i--) {
        //取出子控件
        UIView *childV =  self.subviews[i];
        //把当前的点转换成子控件坐标上的点
        CGPoint childPoint =  [self convertPoint:point toView:childV];
       UIView *fitView =   [childV hitTest:childPoint withEvent:event];
        //判断有没有找到最适合的view
        if(fitView){
            return fitView;
        }
        
    }
    //没有找到比它更合适的view了， 那么它自己就是最适合的
    return self;
}

@end
