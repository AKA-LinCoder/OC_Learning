//
//  DownloadBigBySessionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "DownloadBigBySessionVC.h"

@interface DownloadBigBySessionVC ()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,strong) UIButton *beginBtn;
@property(nonatomic,strong) UIButton *stopBtn;
@property(nonatomic,strong) UIButton *deleteBtn;
@end

@implementation DownloadBigBySessionVC
- (UIProgressView *)progressView
{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 20, 100, 10)];
        _progressView.progress = 0;
    
    }
    return  _progressView;
}
- (UIButton *)beginBtn
{
    if(!_beginBtn){
        _beginBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 80, 40)];
        _beginBtn.titleLabel.text = @"开始下载";
        [_beginBtn setTitle:@"开始下载" forState:UIControlStateNormal];
        [_beginBtn setTintColor:[UIColor whiteColor]];
        _beginBtn.backgroundColor = [UIColor orangeColor];
        [_beginBtn addTarget:self action:@selector(beginDownLoad) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beginBtn;
}

- (UIButton *)stopBtn
{
    if(!_stopBtn){
        _stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 80, 40)];
    
        [_stopBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_stopBtn setTintColor:[UIColor whiteColor]];
        _stopBtn.backgroundColor = [UIColor orangeColor];
        [_stopBtn addTarget:self action:@selector(stopDownLoad) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}

- (UIButton *)deleteBtn
{
    if(!_deleteBtn){
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 80, 40)];
    
        [_deleteBtn setTitle:@"取消下载" forState:UIControlStateNormal];
        [_deleteBtn setTintColor:[UIColor whiteColor]];
        _deleteBtn.backgroundColor = [UIColor orangeColor];
        [_deleteBtn addTarget:self action:@selector(deleteDownLoad) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.beginBtn];
    [self.view addSubview:self.deleteBtn];
    [self.view addSubview:self.stopBtn];
    [self downloadByDelegate];
}
//优点：不需要担心内存
//缺点：无法监听进度
-(void) download1
{
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    //该方法内部实现了边接受数据变写沙盒(tmp)
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //子线程处理
        //拼接文件路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        //剪切文件
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        
    }];
    [task resume];
}

-(void) downloadByDelegate
{
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
   
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    [downloadTask resume];
}

#pragma mark -NSURLSessionDownloadDelegate

/// 当下载完成时调用
/// @param session 会话对象
/// @param downloadTask 下载任务
/// @param location 文件临时存储路径
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    //剪切文件
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
}

/// 当请求结束时调用
/// @param session 会话对象
/// @param task 下载任务
/// @param error 错误
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
}

/// 当恢复下载时调用
/// @param session 会话对象
/// @param downloadTask 下载任务
/// @param fileOffset 从什么地方开始下载
/// @param expectedTotalBytes 文件总大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

/// 写数据
/// @param session 会话对象
/// @param downloadTask 下载任务
/// @param bytesWritten 本次写入数据的大小
/// @param totalBytesWritten 已经下载数据的总大小
/// @param totalBytesExpectedToWrite 文件的总大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //获得下载进度
    self.progressView.progress = 1.0*totalBytesWritten/totalBytesExpectedToWrite;
}

@end
