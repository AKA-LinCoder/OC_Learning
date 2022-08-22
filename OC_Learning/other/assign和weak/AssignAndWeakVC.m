//
//  AssignAndWeakVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "AssignAndWeakVC.h"

@interface AssignAndWeakVC ()
//因为self.view会有一个强引用，所以不需要使用strong
@property(nonatomic,weak) UIView *orangeView;
@end
/*
 基本数据类型用assign,控件用weak
 weak: __weak  弱指针，不会让引用计数器加一，如果指向的对象被销毁，指针会自动清空
 assign: _unsafe_unretained修饰，不会让引用计数器加一，如果指向的对象被销毁，指针不会自动清空
 */
@implementation AssignAndWeakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    self.orangeView = view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.orangeView.frame = CGRectMake(0, 0, 200, 200);
}


@end
