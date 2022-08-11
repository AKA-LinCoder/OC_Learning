//
//  LinOperation.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "LinOperation.h"

@implementation LinOperation
//告知要执行的任务是什么
//1.有利于代码隐蔽
//2.有利于代码复用
- (void)main
//这里面是一个任务
{
    NSLog(@"LinOperation");
    //苹果官方的建议
    if(self.isCancelled) return;
    NSLog(@"LinOperation2");
    if(self.isCancelled) return;
}

- (void)start
{
    //main方法会自动调用start方法
    NSLog(@"start");
    [super start];
    NSLog(@"end");
}

@end
