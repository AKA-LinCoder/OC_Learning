//
//  SDWebVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/11.
//

#import "SDWebVC.h"
#import <SDWebImage/SDWebImage.h>

@interface SDWebVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SDWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:@"people"];
    [self downLoad];
}

/// 下载图片并获取下载进度
/// 内存缓存&磁盘缓存
-(void) downLoad
{
    [self.imageView sd_setImageWithURL:@"https://img2.baidu.com/it/u=46507371,2978896352&fm=253&fmt=auto&app=138&f=JPEG?w=333&h=499" placeholderImage:[UIImage imageNamed:@"people"] options:0 context:nil progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"download OK");
        self.imageView.image = image;
    }];
    //显示GIF
    NSURL *url = [NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201912%2F10%2F20191210083607_eerrv.thumb.1000_0.gif&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662805136&t=169e5ff26c4162facac77f2b96e34d77"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage sd_imageWithGIFData:data];
    self.imageView.image = image;
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
}

/// 适用于简单获取一张图片
/// 内部会做磁盘缓存和内存缓存
-(void) downLoad2
{
    NSURL *url = [NSURL URLWithString:@"https://img2.baidu.com/it/u=46507371,2978896352&fm=253&fmt=auto&app=138&f=JPEG?w=333&h=499"];

    //单纯下载图片
    //SDWebImageManager 在4.0更新后 内部函数downloadImageWithURL 变为loadImageWithURL
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:0 context:nil progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            NSLog(@"download2 OK");
            self.imageView.image = image;
            NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
        }];
        
}

/// 不需要做任何缓存
-(void) downLoad3
{
    NSURL *url = [NSURL URLWithString:@"https://img2.baidu.com/it/u=46507371,2978896352&fm=253&fmt=auto&app=138&f=JPEG?w=333&h=499"];

    NSError *error;
    //单纯下载图片，没有做任何缓存处理，在子线程处理
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:0 context:nil progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            //可以展示进度
        NSLog(@"%@",[NSThread currentThread]);
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            //下载完成
            //在老版本中，这个回调是在子线程的，需要我们回到主线程去更新UI，但是现在经过测试发现处于主线程中
            NSLog(@"%@",[NSThread currentThread]);
            NSLog(@"download3 OK");
            self.imageView.image = image;
            NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
        }];
}

@end
