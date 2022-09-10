//
//  blueView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "blueView.h"

@interface blueView()
//拿不到button
@property(nonatomic,weak)IBOutlet UIButton * btn;
@end

@implementation blueView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    //当点在按钮上的时候，才返回按钮，如果不在按钮上，保持系统默认做法
    //判断点在不在按钮上
    //把当前的点转换到按钮上的坐标系的点
    CGPoint btnP =  [self convertPoint:point toView:self.btn];
    if ([self.btn pointInside:btnP withEvent:event]) {
        return self.btn;
    }else{
        return [super hitTest:point
                    withEvent:event];
    };
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
