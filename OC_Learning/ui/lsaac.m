//
//  lsaac.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/3.
//

#import "lsaac.h"

@implementation lsaac
/*
 1.程序一运行，就创建对象
 2.创建的对象只有一个
 3.只要调用alloc。程序就崩溃
 */
static lsaac *_instance;
+ (void)load
{
    //在类被加载到内存当中就会调用，在main函数之前调用
    NSLog(@"%s",__func__);
    _instance = [[lsaac alloc] init];
}

+ (instancetype)sharedLsaac
{
    return _instance;
}

+ (instancetype)alloc
{
    if(_instance){
        //程序崩溃
        NSException *exc = [NSException exceptionWithName:@"崩溃了" reason:@"没有原因" userInfo:nil];
        [exc raise];
    }
    return [super alloc];
    
}
@end
