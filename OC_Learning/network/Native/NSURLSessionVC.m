//
//  NSURLSessionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "NSURLSessionVC.h"

@interface NSURLSessionVC ()

@end

@implementation NSURLSessionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self taskPost];
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

@end
