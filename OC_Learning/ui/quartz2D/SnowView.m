//
//  SnowView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "SnowView.h"

@implementation SnowView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //这种定时器有点卡顿
//        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeY) userInfo:nil repeats:YES];
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeY)];
        //想让CADisplayLink工作，必须得把她加到主运行循环中
        //当屏幕每次刷新时调用
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];;
    }
    return self;
}

static int snowY = 0;

-(void) changeY
{
    snowY += 10;
    if (snowY>[UIScreen mainScreen].bounds.size.height) {
        snowY = 0;
    }
    //setNeedsDisplay会调用drawRect，但是她并不是立马调用，只是设置了一个标志，等到屏幕刷新时调用
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"雪花"];
    [image drawAtPoint:CGPointMake(0, snowY)];
}

@end
