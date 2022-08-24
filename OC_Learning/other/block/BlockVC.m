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
    ///内存管理
    ///总结：只要block没有引用外部局部变量，block就放还在全局区
    //MRC
    //只要block引用了外部局部变量，block就放在栈里（因为MRC没有强引用的概念，都可以算是基本数据类型）；只要block没有引用外部局部变量，block就放还在全局区；block只能使用copy，不能使用retain，使用retain，block还是在栈里，代码块一过就销毁，可能导致坏的访问；使用copy就会放在堆里；
    //ARC
    //只要block引用了外部局部变量，block就放在堆里
    //block使用strong，最好不要使用copy
    //大部分时间使用copy是没有意义的，使用copy的set方法和使用strong的set方法不一样，以string为例，他使用copy的set方法会进行一系列的判断，判断是否需要分配内存之类，但实际上不需要这些步骤
    int a = 3;
    int(^block3)() = ^int{
        NSLog(@"%d",a);
        return 3;
    };
    NSLog(@"%@",block3);
}

/// block的循环引用
/// @param sender <#sender description#>
- (IBAction)blockCircularReference:(id)sender {
    /*
     循环引用：我引用你，你引用我，就会造成循环引用，双方都不会被销毁，导致内存泄漏
     block造成循环引用：block会对里面所有强指针变量全部强引用
     */
    BlockTableVC *vc = [[BlockTableVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
int c = 1;
/// block变量传递
/// @param sender <#sender description#>
- (IBAction)dataPass:(id)sender {
    int a = 6;
    static int b = 10;
    //如果是局部变量，block是值传递，在定义block时值是多少就是多少，无论后面怎么更改
    //如果是静态变量或者全局变量,__block修饰的变量，block时指针传递，后续修改值会影响
    _block1 = ^{
        NSLog(@"%d",a);
        NSLog(@"%d",b);
        NSLog(@"%d",c);
    };
    a= 7;
    b = 22;
    c = 77;
    _block1();
}
@end
