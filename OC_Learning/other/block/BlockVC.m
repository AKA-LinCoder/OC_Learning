//
//  BlockVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/23.
//

#import "BlockVC.h"
#import "BlockTableVC.h"
//BlockType:类型别名
typedef  void(^BlockType)();
@interface BlockVC ()<BlockTableVCDelegate>
//block怎么声明，就如果定义属性
@property(nonatomic,strong) void(^block1)();
@property(nonatomic,strong) BlockType block123;
@end
/*
 block声明，定义，作用，类型，调用
 作用:保存一段代码
 声明:返回值(^block变量名)(参数)
 定义:
    1. =^(参数){}
    2. 如果没有参数，参数可以隐藏 =^{}，如果有参数，必须写参数，而且必须要有参数变量名
    3. =^int{} ,block的返回可以省略，不管有没有返回值，都可以省略
 类型: 等号左边去掉变量名的就是类型
 调用：变量名()
 快捷方式:输入inli
 */
@implementation BlockVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    void(^block)();
    
    //定义
    void(^block1)() = ^(){
        NSLog(@"this is a block");
    };
    
    _block1 = block1;
    
    int(^block3)() = ^int{
        return 3;
    };
}
//1.在一个方法中定义，在另一个方法中调用
//2.在一个类中定义，在另一个类中调用
- (IBAction)blockSaveCode:(id)sender {
    
    _block1();
    BlockTableVC *vc = [[BlockTableVC alloc] init];
    vc.delegate = self;
    vc.block = ^(NSString *value){
        NSLog(@"这是父视图接受到的数据%@",value);
    };
[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)SendData:(id)sender {
    /*
     顺传：给需要传值的对象，直接定义属性就能传值
     逆传：用代理,block
     */
}

#pragma mark -BlockTableVCDelegate
- (void)BlockTableVC:(BlockTableVC *)vc sendValue:(NSString *)something
{
    NSLog(@"这是获取到的值%@",something);
}

/// 内存管理
/// @param sender 对象
- (IBAction)arcAndmrc:(id)sender {
    //block是OC对象,可以添加到集合中
    /*
     判断当前文件是MRC还是ARC
     1.dealloc 能否调用super，只有MRC才能调用super
     2.能否使用retain，release，如果能用就是MRC
     3.
     */
    /*
     MRC：没有strong，weak，局部变量对象就是相当于基本数据类型
            M RC给成员变量赋值，一定要使用set方法，不能直接访问下划线成员属性赋值
     ARC:只要一个对象没有被强指针修饰就会被销毁，默认局部变量对象都是强指针
     */
    
    //MRC
    //只要block引用了外部局部变量，block就放在栈里（因为MRC没有强引用的概念，都可以算是基本数据类型）；只要block没有引用外部局部变量，block就放还在全局区；block只能使用copy，不能使用retain，使用retain，block还是在栈里，代码块一过就销毁，可能导致坏的访问；使用copy就会放在堆里；
    int a = 3;
    int(^block3)() = ^int{
        NSLog(@"%d",a);
        return 3;
    };
    NSLog(@"%@",block3);
}
@end
