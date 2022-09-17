//
//  WheelBtn.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "WheelBtn.h"

@implementation WheelBtn

//访华当前按钮中图片的尺寸和位置

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat w= 40;
//    CGFloat h= 48;
//    CGFloat x= (contentRect.size.width-w)*0.5;
//    CGFloat y= 20;
//
//}

//设置按钮部分区域可以点击
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat w= (self.bounds.size.width)*0.5;
    CGFloat h= (self.bounds.size.height)*0.5;
    CGRect rect =  CGRectMake(0, 0, w, h);
    if(CGRectContainsPoint(rect, point)){
        return [super hitTest:point withEvent:event];
    }else{
        return nil;
    }
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w= 40;
    CGFloat h= 48;
    CGFloat x= (contentRect.size.width-w)*0.5;
    CGFloat y= 20;
   
    
    return  CGRectMake(x, y, w, h);
}


//取消按钮高亮状态下做的事
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
