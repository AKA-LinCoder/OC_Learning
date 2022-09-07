//
//  FilesVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/7.
//

#import "FilesVC.h"
#import "Person.h"

@interface FilesVC ()

@end

@implementation FilesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //在plist中不能保存自定义的类型
}
//通过归档存储自定义对象
- (IBAction)saveGuiDang:(id)sender {
    Person *people = [Person new];
    people.name = @"林";
    //获取沙盒目录
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"Person.data"];
    if (@available(iOS 12.0,*)){
        NSData *data =  [NSKeyedArchiver archivedDataWithRootObject:people requiringSecureCoding:NO error:nil];
        [data writeToFile:filePath atomically:YES];
    }else{
        [NSKeyedArchiver archiveRootObject:people toFile:filePath];
    }
    NSLog(@"%@",filePath);
   
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
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *guidangPath = [tempPath stringByAppendingPathComponent:@"Person.data"];
    
    
    //读取归档
//    if (@available(iOS 12.0,*)){
    if (@available(iOS 12.0,*)){
        NSError *error;
        NSData *data = [NSData dataWithContentsOfFile:guidangPath];
        Person *p =  [NSKeyedUnarchiver unarchivedObjectOfClass:[Person class] fromData:data error:&error];
        NSLog(@"error:%@",error);
        NSLog(@"%@",p.name);
    }else{
        Person *p =  [NSKeyedUnarchiver unarchiveObjectWithFile:guidangPath];
        NSLog(@"%@",p.name);
    }
   

}
- (IBAction)saveUserDefault:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"my"];
    //立马写入到文件当中
    [defaults synchronize];
    //会默认放到Preferences
}

@end
