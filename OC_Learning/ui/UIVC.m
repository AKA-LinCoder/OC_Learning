//
//  UIVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/3.
//

#import "UIVC.h"
#import "lsaac.h"

@interface UIVC ()
@property(nonatomic,strong)NSArray *array;
@end
/*
 LaunchScreen底层实现：把sb的内容生成图片；
 info.plist文件：设置应用程序配置信息
 PCH文件：存放一些共有的宏；导入公用的头文件；自定义log;
 PCH原理：程序在编译过程，把PCH文件当中内容导入到工程中所有文件中
 */
@implementation UIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"ingo",@"NSThread",@"线程安全",@"NSThread线程间通信",@"GCD",@"GCD线程间通信",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
    lsaac *one = [lsaac sharedLsaac];
    lsaac *two = [lsaac sharedLsaac];
    NSLog(@"one--%p,two--%p",one,two);
    //会崩溃
//    lsaac *three = [[lsaac alloc] init];
//    NSLog(@"one--%p,two--%p,three--%p",one,two,three);
    NSLog(@"%@",NSHomeDirectory());
    LinLog(@"dsa");
   
    
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
//        PthreadVC *vc = [[PthreadVC alloc] init];
//        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
        
    }else if (indexPath.row==2){
        
    }else if (indexPath.row==3){
       
    }else if (indexPath.row==4){
       
    }else if (indexPath.row==5){
       
    }else if (indexPath.row==6){
       
    }else if(indexPath.row ==7){
        
    }else if (indexPath.row == 8){
       
    }else if (indexPath.row==9){
        
    }else if (indexPath.row==10){
        
    }else if (indexPath.row==11){
       
    }else if (indexPath.row==12){
       
    }else if (indexPath.row==13){
        
    }
    
}


@end
