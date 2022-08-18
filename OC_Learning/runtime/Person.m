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
