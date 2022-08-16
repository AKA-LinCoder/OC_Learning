//
//  UploadBySession.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "UploadBySession.h"
#define Kboundary @"----WebKitFormBoundaryjv)UfA04ED44AhWx"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
@interface UploadBySession ()<NSURLSessionDataDelegate>
@property(nonatomic,strong)  NSURLSession *session;
@end

@implementation UploadBySession
- (NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.allowsCellularAccess = YES;
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self upload2];
}
-(void)upload
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/upload"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    //1.设置请求头
    request.HTTPMethod = @"POST";
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary] forHTTPHeaderField:@"Content-type"];
    
    //设置请求体，这样设置没有用，会被忽略
//    request.HTTPBody = [self getBodyData];
    NSLog(@"开始请求");
    NSURLSession *session = [NSURLSession sharedSession];
    //创建上传task,使用下方方式设置请求体
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:[self getBodyData] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    //执行任务
    [task resume];
}

-(void)upload2
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/upload"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    //1.设置请求头
    request.HTTPMethod = @"POST";
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary] forHTTPHeaderField:@"Content-type"];
    
    //设置请求体，这样设置没有用，会被忽略
//    request.HTTPBody = [self getBodyData];
    NSLog(@"开始请求");

    //创建上传task,使用下方方式设置请求体
    NSURLSessionUploadTask *task = [self.session uploadTaskWithRequest:request fromData:[self getBodyData] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
//    执行任务
    [task resume];
}


-(NSData *)getBodyData
{
    //2.按照固定格式拼接数据
    NSMutableData *fileData = [NSMutableData data];
    [fileData appendData: [[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    //name:file 服务器规定的参数
    //filename：文件保存到服务器上的名称
    //Content-Type：文件类型
    [fileData appendData: [@"Content-Disposition:form-data; name=\"file\"; filename=\"Snip.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:KNewLine];
    
    UIImage *image = [UIImage imageNamed:@"people"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [fileData appendData:imageData];
    [fileData appendData:KNewLine];
    //非文件参数
    [fileData appendData: [[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"valveId\""] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:KNewLine];
    [fileData appendData:[[NSString stringWithFormat:@"25132"] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    //结尾标识
    [fileData appendData:[[NSString stringWithFormat:@"--%@--",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return fileData;
}

#pragma mark-delegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%f",1.0*totalBytesSent/totalBytesExpectedToSend);
}
@end
