//
//  NSURLSessionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "NSURLSessionVC.h"

@interface NSURLSessionVC ()<NSURLSessionDataDelegate>
@property(nonatomic,strong) NSMutableData *fileData;
@end

@implementation NSURLSessionVC
- (NSMutableData *)fileData
{
    if(!_fileData){
        _fileData = [NSMutableData data];
    }
    return _fileData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self delegate];
}

-(void) taskPost
{
    //URL
    NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.0.148:8080/haha/app/workBench/getList"];
    //创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    request.HTTPMethod = @"POST";
    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建任务
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //回调是在子线程，如果需要更新UI，还要进行线程间通信
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    //执行
    [task resume];
}

-(void) taskGet
{
    //URL
    NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.0.148:8080/haha/app/workBench/getList"];

    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建任务,当是get请求时可以这样快速创建，内部会创建request
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    //执行
    [task resume];
}
-(void) delegate
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.0.148:8080/haha/app/workBench/getList"];
    //创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    request.HTTPMethod = @"POST";
    //创建会话对象
    //设置回调在哪个线程调用
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task= [session dataTaskWithRequest:request];

    [task resume];
}

#pragma mark - NSURLSessionDataDelegate
//接受到服务器的响应，默认会取消该请求
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"%s",__func__);
    completionHandler(NSURLSessionResponseAllow);
}
//接受到数据 调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"%s",__func__);
    //拼接数据
    [self.fileData appendData:data];
}
//请求接受或者失败的时候调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //解析数据
    NSLog(@"%@",[[NSString alloc] initWithData:self.fileData encoding:NSUTF8StringEncoding]);
}
@end
