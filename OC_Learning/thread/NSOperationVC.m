//
//  NSOperationVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()

@end

@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self task];
}

-(void) task
{
    //1.创建操作，封装任务
    /**
            第三个参数：函数的接受参数
     */
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoad1) object:nil];
    //启动执行操作
//    [op1 start];
    //不配合queue没有任何用，怎么都不会开线程
    //2创建队列
    //主队列(串行队列) [NSOperationQueue mainQueue];和GCD中的主队列一样，放在主队列中的任务会在主线程执行
    //非主队列 [[NSOperationQueue alloc] init];非常特殊，同时具备并发(默认是并发的)和串行的功能
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //3.添加操作到队列中,内部已经调用了start方法
    [queue addOperation:op1];
}
-(void) blockOperation
{
    //追加任务
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    //追加任务
    //如果一个操作中的任务数量大于1，那么会开子线程(并不一定是子线程，可能是主线程)并发执行任务
    [op1 addExecutionBlock:^{
        NSLog(@"这是一条追加任务");
    }];

    
//    [op1 start];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:op1];
    
    //简便方法
    [queue addOperationWithBlock:^{
        NSLog(@"this is a mission");
    }];
    
}
-(void) downLoad1
{
    NSLog(@"%s",__func__);
}

@end
