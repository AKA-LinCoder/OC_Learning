//
//  DragVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "DragVC.h"
#import "moveView.h"
#import "redView.h"
#import "greenView.h"
@interface DragVC ()
@property(nonatomic,strong)moveView *move;
@property(nonatomic,strong)redView *red;
@property(nonatomic,strong)greenView *green;
@end
/*
 在iOS中不是任何对象都能处理事件，只有集成了UIResponder的对象才能接收并处理事件，我们称之为响应者对象
 UIApplication,UIViewController,UIView都继承自UIresponder，因此它们都是响应者对象，都能接收并处理事件
 */
@implementation DragVC

- (moveView *)move
{
    if(_move==nil){
        _move = [[moveView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _move.backgroundColor = [UIColor orangeColor];
    }
    return _move;
}
- (redView *)red
{
    if(_red==nil){
        _red = [[redView alloc] initWithFrame:CGRectMake(300, 100, 100, 100)];
        _red.backgroundColor = [UIColor redColor];
    }
    return _red;
}
- (greenView *)green
{
    if(_green==nil){
        _green = [[greenView alloc] initWithFrame:CGRectMake(100, 90, 100, 100)];
        _green.backgroundColor = [UIColor greenColor];
    }
    return _green;
}
/*
 UIView不接受触摸事件的三种情况
 1.userUbteractionEnabled = NO
 2.hidden = YES
 3.aphla = 0~0.01
 
 当一个控件如果他的父控件不能接受事件，那么它里面的子控件也是不能接受事件的
 当一个控件隐藏的时候，它里面的子控件也跟着隐藏
 当一个控件透明的时候，它里面的子控件也跟着透明
 */

/*
 如何找到最适合的控件来处理事件
 1.自己是否能接受触摸事件
 2.触摸点是否在自己身上
 3.从后往前遍历子控件，重复前面两个步骤
 4.如果没有符合条件的子控件，那么就自己最适合处理
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.move];
    [self.view addSubview:self.red];
    [self.view addSubview:self.green];
    NSLog(@"%@",self.view.subviews);
}




@end
