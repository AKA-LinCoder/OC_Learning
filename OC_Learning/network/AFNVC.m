//
//  AFNVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "AFNVC.h"
#import <AFNetworking/AFNetworking.h>
#define Kboundary @"----WebKitFormBoundaryjv)UfA04ED44AhWx"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
@interface AFNVC ()
@property(nonatomic,strong) UIProgressView *progressView;
@end

@implementation AFNVC
- (UIProgressView *)progressView
{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 20, 100, 10)];
        _progressView.progress = 0;
    
    }
    return  _progressView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:self.progressView];
    [self upload2];
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
-(void) download
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-mc9ef5ja85iv0chp/sc/cae_h264_nowatermark/1615343513/mda-mc9ef5ja85iv0chp.mp4?v_from_s=hkapp-haokan-hna&auth_key=1660533265-0-0-63527dcc58b9cdb7b1a221b55b338f9f&bcevod_channel=searchbox_feed&pd=1&cd=0&pt=3&logid=2664869369&vid=12087023396548225925&abtest=103525_1-103579_2-103890_2&klogid=2664869369"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask =  [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.progressView.progress = 1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //目标回调
        //targetPath 临时文件路径
        //response 响应头信息
        //返回最终路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"haha.mp4"];
        return [NSURL URLWithString:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //filePath：最终文件路径
        NSLog(@"OVER");
    }];
    [downloadTask resume];
}

-(void) upload
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.148:8080/haha/app/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary] forHTTPHeaderField:@"Content-type"];
//    request.HTTPBody = [self getBodyData];
    
    NSURLSessionUploadTask *uploadTask =  [manager uploadTaskWithRequest:request fromData:[self getBodyData] progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.progressView.progress = 1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"%@",responseObject);
    }];
    [uploadTask resume];
}
-(void) upload2
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://192.168.0.148:8080/haha/app/upload" parameters:@{@"valveId":@"25132"} headers:@{@"token":@"token"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {///处理要上传的文件数据
        //使用formData拼接数据
        UIImage *image = [UIImage imageNamed:@"person"];
        NSData *data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"file" fileName:@"hahhah.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.progressView.progress = 1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
    }];
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
@end
