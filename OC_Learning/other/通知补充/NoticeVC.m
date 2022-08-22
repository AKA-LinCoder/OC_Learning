//
//  NoticeVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "NoticeVC.h"

@interface NoticeVC ()
@property(nonatomic,weak) id observe;
@end
/*
 1.如果发送通知
 2.监听通知
 3.通知注意点
 */
@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通知";
    self.view.backgroundColor = [UIColor whiteColor];
    //bug:监听不到通知，马上想到有可能先发出通知，再监听通知
    
    
    //监听通知
    [self listenNoticeOneAsync];

    
    
    
    //先发送，再监听没有效果，必须先监听再发送
}

-(void) listenNoticeOne
{
    //方式一
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotic) name:@"note" object:nil];
    

}
-(void) listenNoticeTwo
{
    //方式二，一般使用主队列，避免block中有更新UI的操作
    self.observe =  [[NSNotificationCenter defaultCenter] addObserverForName:@"note" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //只要监听到通知就会调用
        //queue：决定block发生哪个线程调用，如果传nil，就和发送通知的线程保持一样
            NSLog(@"监听通知回调");
        }];
    

}

-(void) listenNoticeOneAsync
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //方式一
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotic) name:@"note" object:nil];
    });
    

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //发送通知
    //name:通知名称
    //object:谁发送的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"note" object:nil];
}

//一个对象即将销毁就会调用
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
    //方式二的注销
//    [[NSNotificationCenter defaultCenter] removeObserver:self.observe];
}
//监听到通知就会调用
-(void) reciveNotic
{
    //注意点：接受通知的代码，由发出通知的线程决定
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"%s",__func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
        //更新UI
    });
}


@end
