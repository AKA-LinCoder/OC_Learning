//
//  AFNVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "AFNVC.h"
#import <AFNetworking/AFNetworking.h>

@interface AFNVC ()

@end

@implementation AFNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self post];
}

-(void) get
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"" parameters:@{} headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void) post
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://192.168.0.148:8080/haha/app/workBench/getList" parameters:@{} headers:@{@"token":@"token"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"hahahah");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
