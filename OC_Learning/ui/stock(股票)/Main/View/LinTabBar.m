//
//  LinTabBar.m
//  OC_Learning
//
//  Created by Estim on 2022/9/20.
//

#import "LinTabBar.h"
#import "LinButton.h"


@interface LinTabBar()
@property(nonatomic,weak)LinButton *selectedBtn;

@end

@implementation LinTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)setItems:(NSArray *)items
{
    _items = items;
    for (int i = 0; i<self.items.count; i++) {
        LinButton *button = [[LinButton alloc] init];
        [self addSubview:button];
        UITabBarItem *tabBarItem = self.items[i];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [button setBackgroundImage:tabBarItem.image forState:UIControlStateNormal];
        [button setBackgroundImage:tabBarItem.selectedImage forState:UIControlStateSelected];
//        button.titleLabel.text = tabBarItem.title;
        [button setTitle:tabBarItem.title forState:UIControlStateNormal];
        [button setTitle:tabBarItem.title forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//        if (tabBarItem.image!=NULL) {
//            [button setBackgroundImage:tabBarItem.image forState:UIControlStateNormal];
//        }
//        if (tabBarItem.selectedImage!=NULL) {
//            [button setBackgroundImage:tabBarItem.selectedImage forState:UIControlStateSelected];
//        }
    }
}

//当按钮点击时调用
-(void)btnClick:(LinButton *)button
{
    //取消上次选中
    self.selectedBtn.selected = NO;
    //选中当前按钮
    button.selected = YES;
    //记录当前选中
    self.selectedBtn = button;
    //通知外界切换控制器
    if ([self.delegate respondsToSelector:@selector(linTabBar:index:)]) {
        [self.delegate linTabBar:self index:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //调整子控件的frame

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width/self.subviews.count;
    CGFloat h = self.frame.size.height;
    int i = 0;
    for (LinButton *btn in self.subviews) {
        x = w * i;
        btn.tag = i;
        btn.frame = CGRectMake(x, y, w, h);
        if(i==0){
            [self btnClick:btn];
        }
        i++;
        
    }
}


@end
