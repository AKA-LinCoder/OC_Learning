//
//  NSOperationSerndInfoVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "NSOperationSerndInfoVC.h"

@interface NSOperationSerndInfoVC ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong) UIImage *image1;
@property(nonatomic,strong) UIImage *image2;
@end

@implementation NSOperationSerndInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
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
    [self downLoadTwo];
}

-(void) downLoad
{
    //1.开子线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *downLoad = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
        CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
        //下载图片到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
        NSLog(@"end-start=%f",endd-startt);
        //转位image
        UIImage *image = [UIImage imageWithData:imageData];
        NSLog(@"%@",[NSThread currentThread]);
        //回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    
    
    //添加操作到队列
    [queue addOperation:downLoad];
}

/**
 下载图片1
 下载图片2
 合并图片
 */
-(void) downLoadTwo
{
    //1.开子线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //下载图片1
    NSBlockOperation *downLoad1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
        CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
        //下载图片到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
        NSLog(@"end-start=%f",endd-startt);
        //转位image
        self.image1 = [UIImage imageWithData:imageData];
        NSLog(@"%@",[NSThread currentThread]);
    
    }];
    //下载图片2
    NSBlockOperation *downLoad2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
        CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
        //下载图片到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
        NSLog(@"end-start=%f",endd-startt);
        //转位image
        self.image2 = [UIImage imageWithData:imageData];
        NSLog(@"%@",[NSThread currentThread]);
        
    }];
    //合并图片
    NSBlockOperation *com = [NSBlockOperation blockOperationWithBlock:^{
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
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    
    //添加操作依赖
    [com addDependency:downLoad1];
    [com addDependency:downLoad2];
    
    //添加操作到队列，并执行
    [queue addOperation:downLoad1];
    [queue addOperation:downLoad2];
    [queue addOperation:com];
}

@end
