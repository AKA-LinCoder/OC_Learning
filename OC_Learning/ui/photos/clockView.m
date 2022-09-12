//
//  clockView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "clockView.h"

@implementation clockView

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
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        //设置按钮图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
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
