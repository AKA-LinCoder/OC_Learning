//
//  DownloadBigBySessionTwoVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "DownloadBigBySessionTwoVC.h"
#define fileName @"996.mp4"

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
- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue ]];
    }
    return  _session;
}
- (NSString *)fullPath
{
    if (!_fullPath) {
        _fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:fileName];
    }
    return _fullPath;
}
- (NSURLSessionDataTask *)downloadTask
{
    if(!_downloadTask){
        NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
        //获取指定文件路径对应的文件数据大小
        
        self.currentSize = [self getFileSize];
        //设置请求头，告诉服务器请求那一部分
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
      
        _downloadTask = [self.session dataTaskWithRequest:request];
    }
    return _downloadTask;
}
-(NSInteger)getFileSize
{
    NSDictionary *fileInfoDict = [[NSFileManager defaultManager] attributesOfItemAtPath:self.fullPath error:nil];
    NSInteger currentSize = [fileInfoDict[@"NSFileSize"] integerValue];
    NSLog(@"这是从本地获取到的上次下载的数据大小%ld",currentSize);
    return currentSize;
}
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
    NSLog(@"暂停");
    [self.downloadTask suspend];
}
- (IBAction)resumeDownload:(id)sender {
    NSLog(@"恢复");
    [self.downloadTask resume];
}
//取消是不能恢复的
- (IBAction)cancleDownload:(id)sender {
    NSLog(@"取消");
    [self.downloadTask cancel];
    //清空之前数据，让再走一遍懒加载
    self.downloadTask = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void) download
{
    [self.downloadTask resume];

}
#pragma mark-NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //本次请求数据大小
//    self.totalSize = response.expectedContentLength
    //文件总大小=当前请求数据大小+已经下载的大小
    self.totalSize = response.expectedContentLength+self.currentSize;
    //获得文件全路径
//    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    if(self.currentSize==0){
        //创建一个空的文件夹
        [[NSFileManager defaultManager] createFileAtPath:self.fullPath contents:nil attributes:nil];
        
    }
    //创建一个文件句柄
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    //移动指针
    [self.handle seekToEndOfFile];
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
