//
//  SubPerson.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import "SubPerson.h"

@implementation SubPerson
-(void)test
{
    //class:获取当前方法调用者的类
    //superclass:获取当前方法调用者的父类
    //super:仅仅是一个指示器，就是给编译器看的，不是一个指针
    //本质：只要编译器看到super这个标志，就会让当前对象调用父类方法，本质还是当前对象在调用
//    NSLog(@"%@ %@ %@ %@",[self class],[self superclass],[super class],[super superclass]);
    [super test];

}
@end
