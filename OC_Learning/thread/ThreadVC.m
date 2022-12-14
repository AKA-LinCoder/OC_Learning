//
//  ThreadVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/13.
//

#import "ThreadVC.h"
#import "PthreadVC.h"
#import "NSThreadVC.h"
#import "ThreadSafetyVC.h"
#import "ThreadSendInfoVC.h"
#import "GCDVC.h"
#import "GCDSendInfoVC.h"
#import "GCDGroupQueueVC.h"
#import "NSOperationVC.h"
#import "NSOperationSerndInfoVC.h"
#import "ImagedownLoadVC.h"
#import "SDWebVC.h"
#import "NSCachesVC.h"
#import "RunLoopsVC.h"
#import "RunLoopUseVC.h"

@interface ThreadVC ()
@property(nonatomic,strong)NSArray *array;
@end

@implementation ThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"pthread",@"NSThread",@"线程安全",@"NSThread线程间通信",@"GCD",@"GCD线程间通信",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    }else if (indexPath.row==9){
        ImagedownLoadVC *vc = [[ImagedownLoadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==10){
        SDWebVC *vc = [[SDWebVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==11){
        NSCachesVC *vc = [[NSCachesVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==12){
        RunLoopsVC *vc = [[RunLoopsVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==13){
        RunLoopUseVC *vc= [[RunLoopUseVC alloc] init];
        [self presentViewController:vc animated:true completion:nil];
    }
    
}


@end
