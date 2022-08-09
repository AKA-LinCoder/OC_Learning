//
//  ThreadSendInfoVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/9.
//

#import "ThreadSendInfoVC.h"

@interface ThreadSendInfoVC ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ThreadSendInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
}

- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    }
    return _imageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSThread detachNewThreadSelector:@selector(downLoad) toTarget:self withObject:nil];
//    [self downLoad];
}

-(void) downLoad
{
    //下载图片
    NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
    CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
    //下载图片到本地
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
    NSLog(@"end-start=%f",endd-startt);
    //转位image
    UIImage *image = [UIImage imageWithData:imageData];
    NSLog(@"%@",[NSThread currentThread]);
    //第一种写法
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    //第二种写法
//    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    //第三种写法
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];

}

-(void) showImage:(UIImage *) image
{
   
    self.imageView.image = image;
    NSLog(@"%@",[NSThread currentThread]);
    
}



@end
