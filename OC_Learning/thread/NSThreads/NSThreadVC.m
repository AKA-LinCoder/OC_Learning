//
//  NSThreadVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/9.
//

#import "NSThreadVC.h"

@interface NSThreadVC ()
@property(nonatomic,strong)UIButton *nSThreadButton;
@end

@implementation NSThreadVC
//线程的生命周期:当线程中的任务执行完毕之后结束
//线程状态
// alloc init新建线程对象存储在内存中（新建状态）
//start 将线程放入可调度线程池中（就绪状态）
// -(void) start;
//当CPU调度当前线程时，线程处于(运行状态)
//当CPU调度其他线程时，线程处于(就绪状态)
//当调用sleep方法/等待同步锁时处于(阻塞状态),会被移除课调度线程池，但是还在内存中
// +(void) sleepUntilDate:(NSDate *)date;
// +(void) sleepForTiemInterval :(NSDate *)date;
//当线程任务执行完毕，异常/强制退出 ，线程就处于(死亡状态),会被移除课调度线程池，并从内存释放掉
//exit;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nSThreadButton];
    
}

- (UIButton *)nSThreadButton
{
    if(!_nSThreadButton){
        _nSThreadButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [_nSThreadButton setTitle:@"NSThread" forState:UIControlStateNormal];
        _nSThreadButton.backgroundColor = [UIColor orangeColor];
        [_nSThreadButton addTarget:self action:@selector(tapNSThreadButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nSThreadButton;
}
- (void)tapNSThreadButton:(UIButton *)button
{
    
    
    //创建线程
    //第一个参数：目标对象 self
    //第二个对象：方法选择器 调用的方法
    //第三个参数：前面调用方法需要传递的参数
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"ABC"];
    //设置线程属性要在启动之前
    thread.name = @"nsthreadOne";
    //优先级高的先执行(取值范围0-1)默认0.5
    thread.threadPriority = 1;
    //启动线程  进入就绪状态。当线程任务执行完毕，自动进入死亡状态
    [thread start];
    
    //创建线程的方式2，分离一个线程出来,并自动启动,缺点：无法获取线程对象
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"分离子线程"];
    //创建线程的方式3 开启后台线程,缺点：无法获取线程对象
    [self performSelectorInBackground:@selector(run:) withObject:@"开启后台线程"];
    
}

- (void) run:(NSString *)string
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",[NSThread currentThread]);
    
}


@end
