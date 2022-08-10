//
//  LinTool.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "LinTool.h"

//单例
@implementation LinTool
//0.提供全局变量
static LinTool *_intance;

//重写alloc
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    //加一把互斥锁解决多线程访问安全问题
    @synchronized (self) {
        if(!_intance)
        {
            _intance = [super allocWithZone:zone];
        }
    }
    //第二种方式，本身就是线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_intance)
        {
            _intance = [super allocWithZone:zone];
        }
    });
   
    return _intance;
}
//提供类方法
+ (instancetype)sharedTool
{
    return [[self alloc]init];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return  _intance;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return  _intance;
}

//MRC模式下，需要重写release(重写，里面什么也没有，让引用计数器无法减一),retain(返回_instance),retainCount(返回一个很大的数)方法
#if __has_feature(objc_arc)
//NSLog(@"已开启ARC");
#else
//NSLog(@"MRC");

#endif
@end

