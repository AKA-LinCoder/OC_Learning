//
//  ConstVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import "ConstVC.h"
#define lin @"dasd"
//常用字符串，常见基本变量 定义宏

/*
 const和宏的区别
 1.编译时刻 宏：预编译(打开一个项目时，读条) const:编译
 2.编译检查 宏没有编译检查，const有编译检查
 3.宏的好处：定义函数，方法，const不行
 4.宏的坏处：大量使用导致预编译速度太慢;
 
 
 const作用
 1.修饰右边基本变量或者指针变量
 2.被const修饰的变量只读
 
 
 const使用场景
 1.修饰全局变量
 2.修饰方法中参数
 
 const 修饰全局变量
 static 修饰全局变量，修改作用域，修饰局部变量，被static修饰的局部变量，延长生命周期，即整个应用程序有关，被static修饰的局部变量，只会分配一次内存
 
 extern:声明外部全局变量，注意：extern只能用于声明，不能用于定义
 extern工作原理，先会在当前文件下查找有没有对应的全局变量，如果没有，才会去其他文件查找
 
 
 
 */
//不想修改谁就修饰谁
NSString * const name = @"123";
int apple = 1900;
static NSString * const age = @"890"; //static 让age只能在当前文件使用
@interface ConstVC ()

@end

@implementation ConstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //修饰基本变量
    int a = 3;
    int const c = 9;
    const int  b = 4;
    
    int *pp = &a;
    a = 6;
    *pp = 9;
    
    const int *p; //*p不能修改 p：变量能修改
    int * const pppp = &a; //p:不能修改 *p可以修改
//    *p = b;
    //
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",name);

    [self mike];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
/*    static 1.修饰局部变量，被static修饰的局部变量，延长生命周期，即整个应用程序有关，被static修饰的局部变量，只会分配一次内存(程序一运行就会分配)
    2.修饰全局变量，修改作用域，只能在当前文件使用
 */
    static int i = 0;
    i++;
    NSLog(@":%d",i);
}



-(void) mike
{
    NSLog(@"22%@",name);
}

@end
