//
//  Canvas.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/13.
//

#import "Canvas.h"

@interface Canvas()
//当前绘制的路径
@property(nonatomic,strong)  UIBezierPath *path ;
//保存当前绘制的所有路径
@property(nonatomic,strong) NSMutableArray * allPathArray;
@end


@implementation Canvas
- (NSMutableArray *)allPathArray
{
    if(_allPathArray==nil){
        _allPathArray = [NSMutableArray array];
    }
    return _allPathArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pann:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)pann:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:self];
    //判断手势状态
    if(pan.state == UIGestureRecognizerStateBegan){
        
        //创建路径设置起点
        UIBezierPath *path = [UIBezierPath bezierPath];
        self.path = path;
        [path moveToPoint:curP];
        [self.allPathArray addObject:path];
    }else if(pan.state == UIGestureRecognizerStateChanged){
        //绘制一根线到当前手指所在的点
        [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }
}

/// 清屏
-(void) clean
{
    [self.allPathArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}

/// 返回上一步
-(void) reback
{
    [self.allPathArray removeLastObject];
    //重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //绘制保存的所有路径
    for (UIBezierPath *path in self.allPathArray) {
        [path stroke];
    }
    
}


@end
