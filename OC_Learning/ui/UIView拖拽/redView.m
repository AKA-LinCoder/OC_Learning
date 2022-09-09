//
//  redView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "redView.h"

@implementation redView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    return [super hitTest:point withEvent:event];
}

@end
