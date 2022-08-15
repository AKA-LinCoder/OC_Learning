//
//  DownloadBigByConnectionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/15.
//

#import "DownloadBigByConnectionVC.h"

@interface DownloadBigByConnectionVC ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSMutableData *data;
@property(nonatomic,strong) NSString *fullPath;
@property(nonatomic,assign) NSInteger videoSize;
@property(nonatomic,assign) NSInteger currentSize;
@property(nonatomic,strong) NSFileHandle *handle;
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,strong) UIButton *beginBtn;
@property(nonatomic,strong) UIButton *stopBtn;
@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) NSURLConnection *connection;
@end

@implementation DownloadBigByConnectionVC
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
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    //断点下载
    //设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
    [request setValue:range forHTTPHeaderField:@"Range"];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
#pragma mark - delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //1.移动文件句柄到数据的末尾
    [self.handle seekToEndOfFile];
    //2.写数据
    [self.handle writeData:data];
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
//    NSLog(@"%@",self.fullPath);
    //3.创建一个空的文件
    [[NSFileManager defaultManager] createFileAtPath:self.fullPath contents:nil attributes:nil];
    //4.创建一个文件句柄(指针)
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //关闭文件句柄
    [self.handle closeFile];
    self.handle = nil;

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished");
    NSLog(@"%@",self.fullPath);
}
@end
