//
//  RunLoopsVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/12.
//

#import "RunLoopsVC.h"

@interface RunLoopsVC ()
@property(nonatomic,strong)dispatch_source_t timer;
@end

@implementation RunLoopsVC

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"runloop%p",[NSRunLoop currentRunLoop]);
    NSLog(@"mainRunloop%p",[NSRunLoop mainRunLoop]);
    //Core
    NSLog(@"%p",CFRunLoopGetMain());
    NSLog(@"%p",CFRunLoopGetCurrent());
    NSLog(@"%p",[[NSRunLoop mainRunLoop] getCFRunLoop]);
    [[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil] start];
    //创建子线程对应的runloop
    //currentRunLoop内部是懒加载的，所以如果不存在的话就会创建对应的runload
    [NSRunLoop currentRunLoop];
    [self timerGCD];
    
    //这样是不会运行timer的，因为子线程默认没有runloop，必须手动创建
    [NSThread detachNewThreadSelector:@selector(timer2) toTarget:self withObject:nil];
    [self observer];
}
- (IBAction)btn:(id)sender {
    NSLog(@"%s",__func__);
}

-(void) run
{

    NSLog(@"run--%@",[NSRunLoop currentRunLoop].currentMode);
}

-(void) timerr
{
    //1.创建定时器,repeat是否重复
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    //2.添加定时器到RunLoop中,指定runloop的运行模式
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //如果此时页面上触发滑动等其他事件时，会变为其他模式，此时就不会再理会timer，等停止滑动就会回到当前timer
    //当拖拽时工作
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    //NSRunLoopCommonModes=NSDefaultRunLoopMode+UITrackingRunLoopMode
    //NSRunLoopCommonModes占用标签，凡是添加到NSRunLoopCommonModes中的事件都会同时添加到common标签的运行模式上
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void) timer2
{
    
    //创建子线程runloop
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    //该方法内部自动添加到runloop中，并且设置运行模式为默认
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //runloop不会自动运行
    [runloop run];

}
-(void) timerGCD
{
    //1.创建一个GCD定时器
    //不受runloop影响，绝对精准，NSlog中的是打印时间
    //第一个参数：source类型 DISPATCH_SOURCE_TYPE_TIMER 表示是定时器
    //第二个参数：描述信息，定时器用不到
    //第三个参数：更详细的描述信息
    //第四个参数：队列，决定GCD定时器的任务在哪个线程执行
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    //2.设置定时器
    //第一个参数：定时器对象
    //第二个参数：起始时间
    //第三个参数：间隔时间 时间单位为纳秒
    //第四个参数： 精准度，绝对精准 0
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    //4.启动执行
    dispatch_resume(timer);
    //添加强引用避免被释放掉
    self.timer = timer;
}
-(void) observer
{
    
    
    
    //这个并不是监听
//    [NSRunLoop currentRunLoop] addObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>
    //创建监听者
    /**
     第一个参数：怎么分配存储空间
     第二个参数：要监听的状态
     第三个参数：运是否持续监听
     第四个参数：优先级 总是传0
     第五个参数：当状态改变时的回调
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity){
            case  kCFRunLoopEntry:
                NSLog(@"kCFRunLoopEntry");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"kCFRunLoopBeforeTimers");
                break;
            case  kCFRunLoopBeforeSources:
                NSLog(@"kCFRunLoopBeforeSources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"kCFRunLoopBeforeWaiting");
                break;
            case  kCFRunLoopAfterWaiting:
                NSLog(@"kCFRunLoopAfterWaiting");
                break;
            case kCFRunLoopExit:
                NSLog(@"kCFRunLoopExit");
                break;
            default:
                break;
                
        }
    });
    /*
     第一个参数：要监听哪个runloop
     第二个参数：观察者
     第三个参数：运行模式
     **/
  
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
}
@end
