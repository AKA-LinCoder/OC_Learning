//
//  ThreadSafetyVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/9.
//

#import "ThreadSafetyVC.h"

@interface ThreadSafetyVC ()
//售票员A
@property(nonatomic,strong)NSThread *threadA;
//售票员B
@property(nonatomic,strong)NSThread *threadB;
//售票员C
@property(nonatomic,strong)NSThread *threadC;

@property(nonatomic,assign)NSInteger totalCount;
@end

@implementation ThreadSafetyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.totalCount = 100;
    self.threadA = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadB = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadC = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadA.name = @"售票员A";
    self.threadB.name = @"售票员B";
    self.threadC.name = @"售票员C";
    //启动线程
    [self.threadA start];
    [self.threadB start];
    [self.threadC start];
}



-(void) saleTicket
{
    

    
    while (1) {
        //锁必须是全局唯一的
        //互斥锁的位置不能随便加
        //加锁的前置条件：多线程共享同一个资源
        //注意加锁是要付出代价的：需要额外的性能
        //c
        @synchronized (self) {
            NSInteger count = self.totalCount;
            if(count>0){
                for (NSInteger i =0; i<10000; i++) {
                    
                }
                self.totalCount = count - 1;
                NSLog(@"%@卖出去一张,剩下%zd张",[NSThread currentThread],self.totalCount);
            }else{
                NSLog(@"没有了");
                break;
            }
        }
        
        
     
    }
   
}

@end
