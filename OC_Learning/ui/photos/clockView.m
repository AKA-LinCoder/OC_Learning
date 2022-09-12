//
//  clockView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "clockView.h"

@interface clockView()
@property(nonatomic,strong)NSMutableArray *selectBtnArray;
@property(nonatomic,assign)CGPoint curP;
@end

@implementation clockView

- (NSMutableArray *)selectBtnArray
{
    if (_selectBtnArray==nil) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    for (int i = 0; i<9; i++) {
        //创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        //设置按钮图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        //避免按钮拦截touchesBegan
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
    }
}

//按钮会拦截点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当前的手指所在的点在不在按钮上，如果在，让按钮成为选中状态
    CGPoint curP =  [self getCurremtPoint:touches];
    UIButton *btn = [self selectBtn:curP];
    if (btn && btn.isSelected == NO) {
        [btn setSelected:YES];
        [self.selectBtnArray addObject:btn];

    }

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当前的手指所在的点在不在按钮上，如果在，让按钮成为选中状态
    CGPoint curP =  [self getCurremtPoint:touches];
    self.curP = curP;
    UIButton *btn = [self selectBtn:curP];
    if (btn && btn.isSelected == NO) {
        [btn setSelected:YES];
        [self.selectBtnArray addObject:btn];
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableString *str = [NSMutableString string];
    //取消所有选中按钮
    for (UIButton *btn in self.selectBtnArray) {
        btn.selected = NO;
        [str appendFormat:@"%ld",btn.tag];
    }
    //清空路径
    [self.selectBtnArray removeAllObjects];
    [self setNeedsDisplay];
    //查看当前选中按钮顺序

}


- (void)drawRect:(CGRect)rect
{
    if(self.selectBtnArray.count){
        UIBezierPath *path = [UIBezierPath bezierPath];
        //取出所有保存了的按钮
        for (int i = 0; i<self.selectBtnArray.count; i++) {
            //取出每一个按钮
            UIButton *btn = self.selectBtnArray[i];
            if(i==0){
                //设置为路径起点
                [path moveToPoint:btn.center];
            }else{
                //添加一根线到按钮中心
                [path addLineToPoint:btn.center];
            }
        }
        //添加一根线到手指所在点

        [path addLineToPoint:self.curP];


        //设置路径状态
        [[UIColor blueColor]set];
        [path setLineWidth:10];
        [path setLineJoinStyle:kCGLineJoinRound];

        [path stroke];
    }
}


//获取当前手指所在的点
-(CGPoint)getCurremtPoint:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

//给定一个点判断在不在按钮上
-(UIButton *)selectBtn:(CGPoint )curP
{
    //判断点在不在按钮上
    for (UIButton *btn in self.subviews) {
        if(CGRectContainsPoint(btn.frame, curP)){
            //让当前按钮选择
            return btn;
        }
    }
    return nil;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //取出每一个按钮设置frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat btnWH = 74;
    int column= 3;
    CGFloat margin = (self.bounds.size.width - (btnWH*column))/(column+1);
    int curC = 0 ;
    int curR = 0;
    for(int i = 0;i<self.subviews.count;i++){
        //当前所在行
        curC = i % column;
        //当前所在列
        curR = i / column;
        x = margin + (btnWH+margin)*curC;
        y = margin + (btnWH+margin)*curR;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    }
}
@end
