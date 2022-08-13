//
//  RunLoopUseVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/13.
//

#import "RunLoopUseVC.h"

@interface RunLoopUseVC ()
@property(nonatomic,strong)UIButton *createBtn;
@property(nonatomic,strong)UIButton *goOnBtn;
@property(nonatomic,strong)NSThread *thread;

@end

@implementation RunLoopUseVC
- (void)createClick{
   self.thread =  [[NSThread alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [self.thread start];
}
- (void)goOnClick {
    
    [self performSelector:@selector(task2) onThread:self.thread withObject:nil waitUntilDone:YES];
}
- (UIButton *)createBtn
{
    if(!_createBtn){
        _createBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
        _createBtn.backgroundColor = [UIColor orangeColor];
        _createBtn.titleLabel.text = @"create";
        _createBtn.tintColor = [UIColor whiteColor];
        [_createBtn addTarget:self action:@selector(createClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _createBtn;
}

- (UIButton *)goOnBtn
{
    if(!_goOnBtn){
        _goOnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 100, 100)];
        _goOnBtn.backgroundColor = [UIColor redColor];
        _goOnBtn.titleLabel.text = @"goOn";
        _goOnBtn.tintColor = [UIColor whiteColor];
        [_goOnBtn addTarget:self action:@selector(goOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _goOnBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.createBtn];
    [self.view addSubview:self.goOnBtn];
    
}

-(void) task1
{
    NSLog(@"task1-----%@",[NSThread currentThread]);
    //让子线程不死的办法：开runLoop
    //创建runloop
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //为了保证runloop不退出，没有任何实际用
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(runn) userInfo:nil repeats:YES];
//    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //和上面代码一致，保证runloop不停止，添加source
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    //开启
    [runloop run];
    NSLog(@"end");
    
}

-(void) task2
{
    
    //runloop自动释放池第一次创建：启动runloop时
    //runloop自动释放池最后一次销毁，在runloop退出时
    //其他时间的创建和销毁
    //当即将进入休眠前会将之前的销毁，并创建新的
    NSLog(@"task2-----%@",[NSThread currentThread]);
}

-(void) runn
{
    NSLog(@"runn-----%@",[NSThread currentThread]);
}


@end
