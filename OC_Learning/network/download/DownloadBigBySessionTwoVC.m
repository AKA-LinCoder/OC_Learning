//
//  DownloadBigBySessionTwoVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "DownloadBigBySessionTwoVC.h"

@interface DownloadBigBySessionTwoVC ()<NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(nonatomic,strong) NSURLSessionDataTask *downloadTask;
@property(nonatomic,strong) NSData *reumeData;
@property(nonatomic,strong) NSMutableData *filData;
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong) NSFileHandle *handle;
@property(nonatomic,assign) NSInteger totalSize;
@property(nonatomic,assign) NSInteger currentSize;
@property(nonatomic,strong) NSString *fullPath;
@end

@implementation DownloadBigBySessionTwoVC
- (NSMutableData *)filData
{
    if (!_filData) {
        _filData = [NSMutableData data];
    }
    return _filData;
}
- (IBAction)beginDownload:(id)sender {
    [self download];
}
- (IBAction)suspendDownload:(id)sender {
}
- (IBAction)resumeDownload:(id)sender {
}

- (IBAction)cancleDownload:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void) download
{
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue ]];
    NSURLSessionDataTask *downloadTask = [self.session dataTaskWithRequest:request];
    [downloadTask resume];
    self.downloadTask = downloadTask;
}
#pragma mark-NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    self.totalSize = response.expectedContentLength;
    //获得文件全路径
    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    //创建一个空的文件夹
    [[NSFileManager defaultManager] createFileAtPath:self.fullPath contents:nil attributes:nil];
    //创建一个文件句柄
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    completionHandler(NSURLSessionResponseAllow);
}
//持续接受数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //写数据
    [self.handle writeData:data];
    [self.filData appendData:data];
    //计算文件下载进度
    self.currentSize += data.length;
    self.progressView.progress = 1.0*self.currentSize/self.totalSize;
    NSLog(@"%f",1.0*self.currentSize/self.totalSize);
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self.handle closeFile];
    self.handle = nil;
    NSLog(@"%@",self.fullPath);
    if(error){
        NSLog(@"下载异常：%@",error.localizedDescription);
    }else{
        NSLog(@"这次请求完成");
       
    }
   
}
@end
