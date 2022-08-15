//
//  DownloadByOutPutVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/15.
//

#import "DownloadByOutPutVC.h"
#import <SSZipArchive.h>
@interface DownloadByOutPutVC ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSMutableData *data;
@property(nonatomic,strong) NSString *fullPath;
@property(nonatomic,assign) NSInteger videoSize;
@property(nonatomic,assign) NSInteger currentSize;
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,strong) UIButton *beginBtn;
@property(nonatomic,strong) UIButton *stopBtn;
@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) NSURLConnection *connection;
@property(nonatomic,strong) NSOutputStream *stream;
@end

@implementation DownloadByOutPutVC
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
    
}

-(void) beginDownLoad
{
    NSLog(@"开始下载");
    [self downLoad];
}
-(void) stopDownLoad
{
    
}
-(void) deleteDownLoad
{
    NSLog(@"取消下载");
    [self.connection cancel];
}


-(void) downLoad
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
        //断点下载
        //设置请求头
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        //默认在主线程调用的
        //该方法内部会讲connect对象作为一个source添加到当前的runloop中，指定运行模式为默认,且不会释放掉，只有请求完成才会结束
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        //1.方法一：设置代理方法在哪个线程调用
        //不能设置主队列，没有任何用
        [self.connection setDelegateQueue:[[NSOperationQueue alloc] init]];
        

        
        
        //如果使用的是子线程，且connect是局部变量，则必须手动创建子线程的runloop，否则不会运行delegate方法
        //创建子线程的runloop,并且开启runloop,且指定运行模式只能默认
        [[NSRunLoop currentRunLoop] run];
    });
}
-(void) downLoad2
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
        //断点下载
        //设置请求头
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];

        
        //这种方式创建connection,如果指定NO,不会自动请求，需要自己手动开启
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        
        [conn setDelegateQueue:[[NSOperationQueue alloc]init] ];
        //start方法会自动将connection加入runloop，并指定运行模式为默认，如果不存在也会内部创建runloop
        [conn start];
        
        
        //如果使用的是子线程，且connect是局部变量，则必须手动创建子线程的runloop，否则不会运行delegate方法
        //创建子线程的runloop,并且开启runloop,且指定运行模式只能默认
//        [[NSRunLoop currentRunLoop] run];
    });
}
#pragma mark - delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.stream write:data.bytes maxLength:data.length];

    //3.获取进度
    self.currentSize +=data.length;
  
    //进度=已经下载/文件总大小
    NSLog(@"%f",1.0*self.currentSize/self.videoSize);
    self.progressView.progress = 1.0*self.currentSize/self.videoSize;
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //如果写在前面 本次请求的数据大小！=文件总大小
//    self.videoSize = response.expectedContentLength + self.currentSize;
    if (self.currentSize) {
        return;
    }
    
    //1.得到文件的总大小(本次请求的文件数据的总大小)
    self.videoSize = response.expectedContentLength;
    //2.写数据到沙盒
    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
    /**
     第一个参数：文件路径
     第二个参数：YES追加
     */
    //如果输出流指向的位置没有数据，会自己创建
    NSOutputStream *stream = [[NSOutputStream alloc] initToFileAtPath:self.fullPath append:YES];
    [stream open];
    self.stream = stream;

}
//错误时运行
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //关闭流
    [self.stream close];
    self.stream = nil;
    NSLog(@"finished");
    NSLog(@"%@",self.fullPath);
    /**
     压缩文件的存放位置
     要压缩那些文件
     */
    NSString *zipPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.zip"];
    //压缩文件
    [SSZipArchive createZipFileAtPath:zipPath withFilesAtPaths:@[self.fullPath] withPassword:@"1234"];
    //压缩文件夹
//    [SSZipArchive createZipFileAtPath:zipPath withContentsOfDirectory:@"要压缩的文件夹" withPassword:@"789"];
    //解压
    /**
        要压缩的文件在哪里
        文件要解压到什么地方
     */
    [SSZipArchive unzipFileAtPath:@"" toDestination:@"" progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        NSLog(@"%zd----%zd",entryNumber,total);
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"%@",path);
    }];
}
@end
