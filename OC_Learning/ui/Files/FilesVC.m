//
//  FilesVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/7.
//

#import "FilesVC.h"

@interface FilesVC ()

@end

@implementation FilesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)saveToPilst:(id)sender {
    NSArray *dataArray = @[@"123",@"10"];
     NSString *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //拼接文件名
    NSString *filePath =  [path stringByAppendingPathComponent:@"data.plist"];
    NSLog(@"%@",path);
    [dataArray writeToFile:filePath atomically:YES];
    
}

- (IBAction)readFiles:(id)sender {
    NSString *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
   //拼接文件名
   NSString *filePath =  [path stringByAppendingPathComponent:@"data.plist"];
   NSArray *data =   [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@",data);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults objectForKey:@"my"];
    BOOL my =  [defaults boolForKey:@"my"];
    NSLog(@"%ld",my);
}
- (IBAction)saveUserDefault:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"my"];
    //立马写入到文件当中
    [defaults synchronize];
    //会默认放到Preferences
}

@end
