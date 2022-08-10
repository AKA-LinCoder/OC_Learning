//
//  NSOperationVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "NSOperationVC.h"
#import "LinOperation.h"

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
//使用自定义Operation
-(void) downLoad1
{
    //使用场景1，可以将大量的任务
    NSLog(@"%s",__func__);
    LinOperation *op1 = [[LinOperation alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    //将queue由并发队列变为串行队列，将最大并发数1(同一时间可以同时进行的任务为1，就代表所有任务都是串行执行)
    //误区：串行执行任务不等于只开一条线程(线程同步)
    //maxConcurrentOperationCount>1并发队列
    //maxConcurrentOperationCount==1串行队列
    //maxConcurrentOperationCount==0不会执行任务
    //maxConcurrentOperationCount==-1 特殊意义，在大部分情况下-1表示最大值，表示不受限制
    queue.maxConcurrentOperationCount = 1;
    //暂停任务,可以恢复，不能暂停当前正在执行的任务，当任务执行完毕后会暂停
    [queue setSuspended:YES];
//    queue.suspended = YES;
    //恢复
//    queue.suspended = NO;
    [queue setSuspended:NO];
    //取消任务,不可恢复，内部调用了cancel方法
    [queue cancelAllOperations];
    
}

@end
