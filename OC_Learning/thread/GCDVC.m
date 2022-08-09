//
//  GCDVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/9.
//

#import "GCDVC.h"

@interface GCDVC ()

@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self asyncConcurrent];
//    [self asyncSerial];
    [self syncConcurrent];
}
//异步函数+并发队列
-(void)asyncConcurrent
{
    //创建队列
    //第一个参数：标签
    //第二个参数：队列类型DISPATCH_QUEUE_CONCURRENT 并发队列，DISPATCH_QUEUE_SERIAL串行队列
    dispatch_queue_t queue = dispatch_queue_create("first", DISPATCH_QUEUE_CONCURRENT);
    //2.1封装任务 2.2  添加任务到队列中
    //第一个参数：队列
    //第二个参数：任务
    //一个队列中可以有多个任务
    dispatch_async(queue, ^{
        NSLog(@"missionA:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"missionB:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"missionC:%@",[NSThread currentThread]);
    });
}

//异步函数+串行队列
-(void) asyncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("second", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"missionC:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"missionD:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"missionE:%@",[NSThread currentThread]);
    });
}

//同步函数+并行队列
-(void) syncConcurrent
{
    dispatch_queue_t queue = dispatch_queue_create("three", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"missionA:%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"missionB:%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"missionC:%@",[NSThread currentThread]);
    });
}

//同步函数+串行队列
-(void) syncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("four", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"missionA:%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"missionB:%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"missionC:%@",[NSThread currentThread]);
    });
    //获取全局并发队列
    //第一个参数：优先级四个枚举
    //
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}
//异步函数+主队列
-(void)asyncMain
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"missionA:%@",[NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"missionB:%@",[NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"missionC:%@",[NSThread currentThread]);
    });
    
}
//同步函数+主队列：产生死锁，当队列进行到第一个任务的时候将任务从队列中取出准备放到线程中去执行，因为是同步函数（必须等当前代码执行完才能执行），所以此时主线程还在等待执行，
-(void)syncMain
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        NSLog(@"missionA:%@",[NSThread currentThread]);
    });
    dispatch_sync(mainQueue, ^{
        NSLog(@"missionB:%@",[NSThread currentThread]);
    });
    dispatch_sync(mainQueue, ^{
        NSLog(@"missionC:%@",[NSThread currentThread]);
    });
    
}
@end
