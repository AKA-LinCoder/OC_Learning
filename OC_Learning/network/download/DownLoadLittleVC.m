//
//  DownLoadLittleVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/15.
//

#import "DownLoadLittleVC.h"

@interface DownLoadLittleVC ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSMutableData *data;
@property(nonatomic,assign) NSInteger videoSize;
@end

@implementation DownLoadLittleVC
- (NSMutableData *)data
{
    if(!_data){
        _data = [NSMutableData data];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self downLoad3];
    
}

//耗时操作
-(void) downLoad1
{
    NSURL *url = [NSURL URLWithString:@"https://img0.baidu.com/it/u=2672478206,3045278965&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
}
//无法监听进度
//data一次返回，很容易内存崩溃，内存飙升
-(void) downLoad2
{
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
        NSLog(@"%@",fullPath);
        [data writeToFile:fullPath atomically:YES];
    }];
}
//通过delegate下载
//内存飙升问题
-(void) downLoad3
{
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
#pragma mark - delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  
    [self.data appendData:data];
    //进度=已经下载/文件总大小
    NSLog(@"%f",1.0*self.data.length/self.videoSize);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //得到文件总大小
    //本次请求总大小
    self.videoSize = response.expectedContentLength;
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished");
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
    NSLog(@"%@",fullPath);
    [self.data writeToFile:fullPath atomically:YES];
    
}
@end
