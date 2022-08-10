//
//  GCDGroupQueueVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "GCDGroupQueueVC.h"

@interface GCDGroupQueueVC ()
@property(nonatomic,strong) UIImage *image1;
@property(nonatomic,strong) UIImage *image2;
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation GCDGroupQueueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
#if __has_feature(objc_arc)
NSLog(@"已开启ARC");
#else
NSLog(@"MRC");

#endif
}
- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 300, 300)];
    }
    return _imageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self group3];
}
/// 新写法
-(void) groupNew
{
    //1.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.获取队列组
    dispatch_group_t group = dispatch_group_create();
    //3.异步函数
    //会监听任务的执行情况，并通知group
    dispatch_group_async(group, queue, ^{
        NSLog(@"missionA,%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"missionB,%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"missionC,%@",[NSThread currentThread]);
    });
    //拦截通知，当队列组任务执行完毕后执行
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finished");
    });
}
///老写法
-(void) groupOld
{
    //1.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.获取队列组
    dispatch_group_t group = dispatch_group_create();
    //3.在该方法后面的异步任务回呗纳入队列组的监听范围，进入群组,进入和离开必须配对使用
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"local mission1");
        //离开群组
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"local mission2");
        //离开群组
        dispatch_group_leave(group);
    });
    //拦截通知方法1，当队列组任务执行完毕后执行,这个方法本身是异步的，不是阻塞的
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finished");
    });
    //拦截通知方法2
    //DISPATCH_TIME_FOREVER:死等，直到队列组中任务执行完毕才执行
    //这个方法是阻塞的，必须等执行完才执行
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"-----");
}

-(void) group3
{
    //11.下载图片1，开子线程
    //2.下载图片2，开子线程
    //3.合成图片显示，开子线程
    NSLog(@"%s",__func__);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        //下载图片
        NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
        CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
        //下载图片到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
        NSLog(@"end-start=%f",endd-startt);
        //转位image
        self.image1 = [UIImage imageWithData:imageData];
    });
    //下载第二个图片
    dispatch_group_async(group, queue, ^{
        //下载图片
        NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
        CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
        //下载图片到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
        NSLog(@"end-start=%f",endd-startt);
        //转位image
        self.image2 = [UIImage imageWithData:imageData];
    });
    //当前面两个方法执行完之后合成图片
    dispatch_group_notify(group, queue, ^{
        //1.创建图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        //2.画图1
        [self.image1 drawInRect:CGRectMake(0, 0, 300, 150)];
        self.image1 = nil;
        //3.画图2
        [self.image2 drawInRect:CGRectMake(0, 150, 300, 150)];
        self.image2 = nil;
        //4.根据上下文得到一张图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //5.关闭上下文
        UIGraphicsEndImageContext();
        //6.更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新UI");
            self.imageView.image = image;
        });
        //另一种写法
        //第一个参数：队列
        //第二个参数：函数的参数
        //第三个参数：要执行的函数
        dispatch_async_f(queue, NULL, myTask);
    });
    
}
void myTask(void *param)
{
    
}
@end
