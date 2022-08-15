//
//  UploadByConnectionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/15.
//

#import "UploadByConnectionVC.h"
#define Kboundary @"----WebKitFormBoundaryjv)UfA04ED44AhWx"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
@interface UploadByConnectionVC ()

@end

@implementation UploadByConnectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self uploadData];

}
-(void) uploadData
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/upload"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    //1.设置请求头
    request.HTTPMethod = @"POST";
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary] forHTTPHeaderField:@"Content-type"];

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
    //设置请求体
    request.HTTPBody = fileData;
    NSLog(@"开始请求");
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}

@end
