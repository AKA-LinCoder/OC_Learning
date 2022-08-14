//
//  NativeVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/14.
//

#import "NativeVC.h"

@interface NativeVC ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSMutableData *resultData;
@end

@implementation NativeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self delegate];
}
- (NSMutableData *)resultData
{
    if (!_resultData) {
        _resultData = [NSMutableData data];
    }
    return _resultData;
}
/*
 请求：请求头(NSURLRequest默认包含)+请求体(Get没有)
 响应:响应头(真实类型->NSHTTPURLResponse)
 **/
-(void) sendGet
{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/workBench/getList"];
    //2.创建请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //3.发送请求
    /***
     第一个参数：请求对象
     第二个参数：响应头信息
     第三个参数：错误信息
     返回值：响应体
     */
    
    //真实类型
    NSHTTPURLResponse *response = nil;
    //同步请求，会阻塞
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"response%ld",(long)response.statusCode);
    //4.解析data->字符串
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"请求结果:%@",dataString);
}

-(void) sendAsyncGet
{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/workBench/getList"];
    //2.创建请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //3.发送请求
    /***
     第一个参数：请求对象
     第二个参数：队列，决定completionHandler代码块的调用线程
     第三个参数：请求回调
     返回值：响应体
     */
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //response:响应头
        //data:响应体
        //error
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"res:%ld",(long)res.statusCode);
        //4.解析data->字符串
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"请求结果2:%@",dataString);
    }];
}
-(void)delegate
{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/workBench/getList"];
    //2.创建请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //3.1设置代理发送网络请求
//    [NSURLConnection connectionWithRequest:request delegate:self];
    //3.2，设置代理，并不会发送请求，只有第三个参数为YES，或者手动发送
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO ];
    [connect start];
    [connect cancel];
    
}
#pragma mark -NSURLConnectionDataDelegate
//1.当接受到服务器响应的时候调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%s",__func__);
}
//2.节后到服务器返回数据的时候调用,可能会调用多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%s",__func__);
    //拼接数据
    [self.resultData appendData:data];
}
//3.当请求失败的时候
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}


//4.请求结束的时候调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%s",__func__);
    //解析数据
    NSString *dataString = [[NSString alloc] initWithData:self.resultData encoding:NSUTF8StringEncoding];
    NSLog(@"请求结果3:%@",dataString);
}
@end
