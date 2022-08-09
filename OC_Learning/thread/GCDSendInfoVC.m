//
//  GCDSendInfoVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/9.
//

#import "GCDSendInfoVC.h"

@interface GCDSendInfoVC ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation GCDSendInfoVC

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
    //1.创建子线程下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载图片
        NSURL *url = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1979270545,955733226&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=611"];
        CFTimeInterval startt = CFAbsoluteTimeGetCurrent();
        //下载图片到本地
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        CFTimeInterval endd = CFAbsoluteTimeGetCurrent();
        NSLog(@"end-start=%f",endd-startt);
        NSLog(@"%@",[NSThread currentThread]);
        //转位image
        UIImage *image = [UIImage imageWithData:imageData];
        //更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            NSLog(@"%@",[NSThread currentThread]);
        });
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
