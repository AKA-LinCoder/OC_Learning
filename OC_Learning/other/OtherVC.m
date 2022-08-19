//
//  OtherVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import "OtherVC.h"
#import "SuperClassAndClassVC.h"
@interface OtherVC ()
@property(nonatomic,strong)NSArray *array;
@end

@implementation OtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"super,superClass,class",@"runtimeKVC",@"线程安全",@"NSThread线程间通信",@"GCD",@"GCD线程间通信",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
   
    
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
        SuperClassAndClassVC *vc = [[SuperClassAndClassVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
//        runtimeKVCVC *vc = [[runtimeKVCVC alloc] init];
//              [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==2){
//        PthreadVC *vc = [[PthreadVC alloc] init];
      //        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==3){
//        PthreadVC *vc = [[PthreadVC alloc] init];
      //        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==4){
//        GCDVC *vc = [[GCDVC alloc] init];
//        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==5){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
               
    }else if (indexPath.row==6){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
               
    }else if(indexPath.row ==7){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
               
    }else if (indexPath.row == 8){
        //        PthreadVC *vc = [[PthreadVC alloc] init];
        //        [self presentViewController:vc animated:YES completion:nil];
               
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
//        RunLoopUseVC *vc= [[RunLoopUseVC alloc] init];
//        [self presentViewController:vc animated:true completion:nil];
    }
    
}


@end
