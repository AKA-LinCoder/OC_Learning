//
//  Canvas.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/13.
//

#import "Canvas.h"
#import "MyBezierPath.h"

@interface Canvas()
//当前绘制的路径
@property(nonatomic,strong)  MyBezierPath *path ;
//当前颜色
@property(nonatomic,strong)  UIColor *stokeColor ;
//当前颜色
@property(nonatomic,assign)  CGFloat stokeWidth ;
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
        self.stokeWidth = 1;
        self.stokeColor = [UIColor blackColor];
    }
    return self;
}

-(void)pann:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:self];
    //判断手势状态
    if(pan.state == UIGestureRecognizerStateBegan){
        
        //创建路径设置起点
        MyBezierPath *path = [MyBezierPath bezierPath];
        self.path = path;
        [path moveToPoint:curP];
        [path setLineWidth:self.stokeWidth];
        path.color = self.stokeColor;
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
    for (MyBezierPath *path in self.allPathArray) {
        //判断取出来的类型
        if([path isKindOfClass:[UIImage class]]){
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else if([path isKindOfClass:[MyBezierPath class]]){
            [path.color set];
            [path stroke];
            
        }
       
    }
    
}

-(void)setLineColor:(UIColor *)color
{
    self.stokeColor = color;
}

-(void)setLineWidth:(CGFloat )width
{
    self.stokeWidth = width;
}

-(void)eraser
{
    self.stokeColor = [UIColor whiteColor];
    self.stokeWidth = 10;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    //添加图片到数组中
    [self.allPathArray addObject:image];
    //重绘
    [self setNeedsDisplay];
}

@end
