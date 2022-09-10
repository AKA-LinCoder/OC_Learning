//
//  addBtn.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/10.
//

#import "addBtn.h"

@implementation addBtn

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.popBtn) {
        //判断当前点在不在popbtn上
        CGPoint popP = [self convertPoint:point toView:self.popBtn];
        if([self.popBtn pointInside:popP withEvent:event]){
            return self.popBtn;
        }else{
            return [super hitTest:point
                        withEvent:event];
        }
      
    }else{
        return [super hitTest:point
                    withEvent:event];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.获取UItouch
    UITouch *toouch = [touches anyObject];
    //2.获取当前手指的点，上一个手指的点
    CGPoint curP = [toouch locationInView:self];
    CGPoint perP = [toouch previousLocationInView:self];
    //3.计算偏移量
    CGFloat offsetX= curP.x-perP.x;
    CGFloat offsetY = curP.y-perP.y;
    //4.平移
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

/*
 响应者链条：由多个响应者对象连接起来的链条
 作用：能很清楚的看见每个响应者之间的联系，并可以让一个事件多个对象处理
 响应者对象：能处理事件的对象
 touchesBegan:默认将事件顺着响应者链条向上传递，将事件交给上一个响应者进行处理
 
 1.先去判断当前的view是不是控制器的view。如果单曲的view是控制器的view，那么它上一个响应者就是它所在的看控制器
 2.如果当前的view，不是控制器的view，那么它上一个响应者就是它的父控件
 
 */

/*
 事件传递的完整过程
 1.先将事件对象由上往下传递(父控件传递给子控件),找到最合适的控件来处理这个事件
 2.调用最合适控件的touches。。方法
 3.如果调用了[super touches。。。],就会将事件顺着响应者链条往上传递，传递给上一个响应者
 4.接着就会调用上一个响应者的touches。。。方法
 */

@end
