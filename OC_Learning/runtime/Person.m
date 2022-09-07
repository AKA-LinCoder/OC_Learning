//
//  Person.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person
- (void)eat
{
    NSLog(@"eat");
}
- (void)run:(NSInteger)m
{
    NSLog(@"run l %ld",(long)m);
}
//ios12后解档使用
+ (BOOL)supportsSecureCoding
{
    return YES;
}
//告诉要保存当前对象的那些属性
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
}
//解读数据使用,告诉要解析文件中的哪些属性
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
       self.name =  [coder decodeObjectForKey:@"name"];
    }
    return self;
}


-(void)test
{
    {
        //class:获取当前方法调用者的类
        //superclass:获取当前方法调用者的父类
        //super:仅仅是一个指示器，就是给编译器看的，不是一个指针
        //本质：只要编译器看到super这个标志，就会让当前对象调用父类方法，本质还是当前对象在调用
        
        
        
        //查看super：clang -rewrite-objc main.m 会发现super实际上调用了 objc_msgSendSuper(x,x,x)其中第一个参数传的是self，代表是当前对象
        
        NSLog(@"%@ %@ %@ %@",[self class],[self superclass],[super class],[super superclass]);

    }
}

//只要一个对象调用了一个未实现的方法就会调用这个方法，进行处理
//作用：动态添加方法，或者处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel ==NSSelectorFromString(@"sleep")){
        /*
         //给哪个类添加方法
         //添加哪个方法
         //方法实现=>函数名=>函数入口=>函数名
         //方法类型
         */
        class_addMethod(self, sel, (IMP)aaa, "v@:");
        return YES;
    }
    if (sel == NSSelectorFromString(@"pp:")) {
        class_addMethod(self, sel, (IMP)ppp, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//任何方法默认都有两个阴式参数 self,_cmd
//_cmd:当前方法的方法编号
void aaa(id self,SEL _cmd){
    NSLog(@"这是在睡觉么");
}

void ppp(id self,SEL _cmd,NSNumber *meter){
    NSLog(@"这是在锻炼吧%@",meter);
}

@end
