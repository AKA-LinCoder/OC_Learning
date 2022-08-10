//
//  ViewController.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

#import "ViewController.h"
#import "PthreadVC.h"
#import "NSThreadVC.h"
#import "ThreadSafetyVC.h"
#import "ThreadSendInfoVC.h"
#import "GCDVC.h"
#import "GCDSendInfoVC.h"
#import "GCDGroupQueueVC.h"
#import "NSOperationVC.h"
#import "NSOperationSerndInfoVC.h"




#pragma  mark - controller
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *array;
@end

@implementation ViewController
- (IBAction)myBUtton:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.获取主线程
    NSThread *mainThread = [NSThread mainThread];
    NSLog(@"%@",mainThread);
    //2.获取当前线程
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"%@",currentThread);
    self.array = @[@"pthread",@"NSThread",@"线程安全",@"NSThread线程间通信",@"GCD",@"GCD线程间通信",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载"];
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        PthreadVC *vc = [[PthreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
        NSThreadVC *vc = [[NSThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==2){
        ThreadSafetyVC *vc = [[ThreadSafetyVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==3){
        ThreadSendInfoVC *vc = [[ThreadSendInfoVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==4){
        GCDVC *vc = [[GCDVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==5){
        GCDSendInfoVC *vc = [[GCDSendInfoVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==6){
        GCDGroupQueueVC *vc = [[GCDGroupQueueVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if(indexPath.row ==7){
        NSOperationVC *vc = [[NSOperationVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row == 8){
        NSOperationSerndInfoVC *vc = [[NSOperationSerndInfoVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}


@end


