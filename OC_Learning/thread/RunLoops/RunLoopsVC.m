//
//  RunLoopsVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/12.
//

#import "RunLoopsVC.h"

@interface RunLoopsVC ()

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
    [self timer];
    
    //这样是不会运行timer的，因为子线程默认没有runloop，必须手动创建
    [NSThread detachNewThreadSelector:@selector(timer2) toTarget:self withObject:nil];
}
-(void) run
{
    NSLog(@"run--%@",[NSRunLoop currentRunLoop].currentMode);
}

-(void) timer
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
@end
