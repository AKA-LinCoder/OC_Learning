//
//  DrawerVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/10.
//

#import "DrawerVC.h"

@interface DrawerVC ()
@property(nonatomic,weak)UIView *leftView;
@property(nonatomic,weak)UIView *mainView;
@property(nonatomic,weak)UIView *rightView;
@end

@implementation DrawerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
//    NSLog(@"%@",self.view.frame);
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pann:)];
    [self.mainView addGestureRecognizer:pan];
    
    //给控制器的view添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
}

-(void) tap{
    //让manview复位
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

-(void) setUpUI
{
    //左边UI
    UIView *leftView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    leftView.backgroundColor = [UIColor blueColor];
   
    //右边UI
    UIView *rightView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    rightView.backgroundColor = [UIColor greenColor];
    //中间UI
    UIView *mainView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    mainView.backgroundColor = [UIColor redColor];
    self.leftView = leftView;
    self.rightView = rightView;
    self.mainView = mainView;
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:mainView];
    
    
}
#define targetR 275
#define targetL -275
#define ScreenW [UIScreen mainScreen].bounds.size.width
-(void)pann:(UIPanGestureRecognizer *)pan
{
    //获取偏移量
    CGPoint point = [pan translationInView:self.mainView];
    //为什么不使用transform，因为我们还需要修改高度，transform只能修改x ，y
//    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, point.x
//                                                         , 0);
   
    self.mainView.frame = [self frameWithOffsetX:point.x];
    //判断拖动方向
    if(self.mainView.frame.origin.x>0)
    {//向右
        [self.rightView setHidden:YES];
    }else{
        //向左
        [self.rightView setHidden:NO];
    }
    CGFloat target = 0;
    //当手指松开时，自动定位
    if(pan.state == UIGestureRecognizerStateEnded){
        
        if(self.mainView.frame.origin.x>ScreenW *0.5){
            //判断在右侧
            //当前view的x有没有大于屏幕宽度的一半，就是在右侧
            target = targetR;
        }else if (CGRectGetMaxX(self.mainView.frame)<ScreenW *0.5){
            //判断在左侧
            //当前view的最大x有没有小于屏幕宽度的一半，就是在左侧
            target = targetL;
        }
        //计算当前mainView的frame
        CGFloat offset = target-self.mainView.frame.origin.x;
        [UIView animateWithDuration:0.5 animations:^{
            self.mainView.frame =  [self frameWithOffsetX:offset];
        }];
      
       
    }
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainView];
}
#define maxY 100
//根据偏移量修改Frame
-(CGRect) frameWithOffsetX:(CGFloat) offsetX
{
    CGRect frame = self.mainView.frame;
    frame.origin.x += offsetX;
  
    //当拖动的view的X值等于屏幕宽度时，MaxY=100
    //取绝对值
    frame.origin.y = fabs((frame.origin.x) * (maxY) / ([UIScreen mainScreen].bounds.size.width));
    //屏幕的高度-两倍的y值
    frame.size.height = [UIScreen mainScreen].bounds.size.height-2*(frame.origin.y);
    
    
    
    return frame;
}
@end
