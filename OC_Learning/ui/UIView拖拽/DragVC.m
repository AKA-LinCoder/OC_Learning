//
//  DragVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "DragVC.h"
#import "moveView.h"

@interface DragVC ()
@property(nonatomic,strong)moveView *move;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.move];
}




@end
