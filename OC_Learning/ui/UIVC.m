//
//  UIVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/3.
//

#import "UIVC.h"
#import "lsaac.h"
#import "PickerVC.h"
#import "SelfPickerVC.h"

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
    self.array = @[@"picker",@"自定义Picker",@"线程安全",@"NSThread线程间通信",@"GCD",@"GCD线程间通信",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
    lsaac *one = [lsaac sharedLsaac];
    lsaac *two = [lsaac sharedLsaac];
    NSLog(@"one--%p,two--%p",one,two);
    //会崩溃
//    lsaac *three = [[lsaac alloc] init];
//    NSLog(@"one--%p,two--%p,three--%p",one,two,three);
    NSLog(@"%@",NSHomeDirectory());
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"] options:@{} completionHandler:^(BOOL success) {
//            
//    }];
    LinLog(@"dsa");
    //
//    self.view.alpha = 0;
    //如果一个view的alpha为0，那么它是不能接受点击事件的
    //默认控制器颜色是透明的
//    self.view.backgroundColor = [UIColor clearColor];
   
    
}

//用来创建控制器的view
//当控制器的view第一次使用的时候调用
//底层原理：
/*
    1.先判断当前控制器是不是从sb中加载的，如果是，就会从sb当中加载的控制器的view，设置当前控制器的view
    2.判断控制器是否是从xib中加载的，如是就将xib中指定的view设置为控制器的view
    3.如果都不是，就会创建空白的view
 一旦重写了loadview方法，就说明要自己定义view
 */
//使用场景：当控制器的view一显示时就是一张图片或者UIwebView
//可以节省内存
//- (void)loadView
//{
//    //如果一个控件不能够接收事件，那么它里面的子控件也是不能接受事件的
//}


/*
 view方法是懒加载的,不能在当前控制器设置view颜色是什么，最终都是由外部调用时决定的
 */
//- (UIView *)view
//{
//    if(self.view==nil){
//        [self loadView];
//        [self viewDidLoad];
//    }
//    return self.view;
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
//    UIStatusBarStyle *style = [[UIstatusBarStyle alloc] init];
    return UIStatusBarStyleLightContent;
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
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
        PickerVC *vc = [[PickerVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

       
    }else if(indexPath.row==1){
        SelfPickerVC *vc = [[SelfPickerVC alloc] init];
//        vc.view.backgroundColor = [UIColor redColor];
        [self.navigationController pushViewController:vc animated:YES];
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
