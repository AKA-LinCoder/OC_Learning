//
//  NetWorkVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/13.
//

#import "NetWorkVC.h"
#import "NativeVC.h"
#import "JSONDataShowVC.h"
#import "XMLVC.h"
#import "DownLoadLittleVC.h"
#import "DownloadBigByConnectionVC.h"
#import "DownloadByOutPutVC.h"
#import "UploadByConnectionVC.h"
#import "NSURLSessionVC.h"
#import "DownloadBigBySessionVC.h"

@interface NetWorkVC ()
@property(nonatomic,strong)NSArray *array;
@end

@implementation NetWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"原生请求",@"JSON反序列化展示数据",@"XML文件解析",@"小文件下载",@"使用NSURLConnection下载大文件",@"通过输出流下载文件",@"使用NSURLConnection上传文件",@"使用NSURLSession网络请求",@"使用NSURLSession网络下载大文件",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        NativeVC *vc = [[NativeVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
        JSONDataShowVC *vc = [[JSONDataShowVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==2){
                XMLVC *vc = [[XMLVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==3){
        DownLoadLittleVC *vc = [[DownLoadLittleVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==4){
        DownloadBigByConnectionVC *vc = [[DownloadBigByConnectionVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==5){
                DownloadByOutPutVC *vc = [[DownloadByOutPutVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==6){
                UploadByConnectionVC *vc = [[UploadByConnectionVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if(indexPath.row ==7){
        NSURLSessionVC *vc = [[NSURLSessionVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row == 8){
        DownloadBigBySessionVC *vc = [[DownloadBigBySessionVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==9){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==10){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==11){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==12){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==13){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
    }
    
}
@end
