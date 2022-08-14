//
//  NativeVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/14.
//

#import "NativeVC.h"

@interface NativeVC ()

@end

@implementation NativeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self sendAsyncGet];
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

@end
