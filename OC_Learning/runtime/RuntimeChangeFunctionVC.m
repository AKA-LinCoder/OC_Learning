//
//  RuntimeChangeFunctionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "RuntimeChangeFunctionVC.h"
#import "Person.h"
#import "NSObject+property.h"

@interface RuntimeChangeFunctionVC ()

@end

@implementation RuntimeChangeFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //想要修改系统的方法时，只能使用runtime(交换方法)
    //1.给系统的方法添加分类
    //2.自己实现一个带有拓展功能的方法
    //3.交换方法
    
    
    /*
        需求：让UIImage加载图片，告诉我是否加载成功->使用runtime交换方法
     解决：1.自定义UIImage，弊端：每次使用都要导入；项目大了没法后期实现
        2.分类：不能使用，会覆盖原有方法
     只能使用runtime
     */
    //在分类中，最好不要重写系统方法，一旦重写，会把系统方法给干掉
//    UIImage *image = [UIImage lin_imageNamed:@"people"];
    UIImage *image = [UIImage imageNamed:@"people"];
    
    //Runtime动态添加方法：OC都是懒加载机制，只要一个方法实现了，就会马上添加到方法列表中，
    //performSelector
    Person *p = [Person new];
    //执行方法，编译时不会坚持到底有没有这个方法，只有在真正执行的时候才会判断
    [p performSelector:@selector(sleep)];
    [p performSelector:@selector(pp:) withObject:@10];
    
    //runtime一般都是针对系统的类
    
    //什么时候需要动态添加属性
    //给系统的类添加属性的时候使用
    //添加属性本质：让某一个属性与某个对象产生一个关联
    //需求：让一个NSObject类保存一个字符串
    NSObject *objct = [NSObject new];
    objct.name = @"123";
    
}



@end
