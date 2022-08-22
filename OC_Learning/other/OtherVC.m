//
//  OtherVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import "OtherVC.h"
#import "SuperClassAndClassVC.h"
#import "ConstVC.h"
#import "FatherAndSonVC.h"
#import "ExtensionWangyiVC.h"
#import "ScrollviewAutoLayoutVC.h"
#import "SizeAndCenterVC.h"
#import "NoticeVC.h"
#import "EnumVC.h"
#import "AssignAndWeakVC.h"
#import "FrameAndBoundsVC.h"
@interface OtherVC ()
@property(nonatomic,strong)NSArray *array;
@end

@implementation OtherVC
extern int apple;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"这是本view2的宽度%f",self.view.bounds.size.width);
    self.array = @[@"super,superClass,class",@"const",@"父子控制器",@"网易新闻",@"UIScrollview自动布局",@"Size和center",@"通知补充",@"枚举的位运算",@"weak以及assign",@"frame和bounds",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
    NSLog(@"这是通过extern声明的apple%d",apple);
    
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
        [self.navigationController pushViewController:vc animated:YES];
       
    }else if(indexPath.row==1){
        ConstVC *vc = [[ConstVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
       
        FatherAndSonVC *vc = [[FatherAndSonVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3){
        ExtensionWangyiVC *vc = [[ExtensionWangyiVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
        ScrollviewAutoLayoutVC *vc = [[ScrollviewAutoLayoutVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==5){
        SizeAndCenterVC *vc = [[SizeAndCenterVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==6){
        NoticeVC *vc = [[NoticeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
               
    }else if(indexPath.row ==7){
        EnumVC *vc = [[EnumVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row == 8){
        AssignAndWeakVC *vc = [[AssignAndWeakVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
               
    }else if (indexPath.row==9){
        FrameAndBoundsVC *vc = [[FrameAndBoundsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
               
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
