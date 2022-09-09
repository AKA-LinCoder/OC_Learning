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
#import "AddressBoolLoginVC.h"
#import "FilesVC.h"
#import "SelfPageVC.h"
#import "TemplateVC.h"
#import "ModalVC.h"
#import "TransformVC.h"
#import "DragVC.h"

@interface UIVC ()
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)ModalVC *modalVC;
@end
/*
 LaunchScreen底层实现：把sb的内容生成图片；
 info.plist文件：设置应用程序配置信息
 PCH文件：存放一些共有的宏；导入公用的头文件；自定义log;
 PCH原理：程序在编译过程，把PCH文件当中内容导入到工程中所有文件中
 */

/*
 字符串使用strong的原因，因为在开发中的大部分时间内，我们使用的String都是不可变的，如果将属性设置为copy，在执行对应属性的set方法时，会先去判断一次传入是个可变还是不可变的，如果可变会创建新的空间，这样字符串多了就会消耗过多不必要的性能
 使用copy的原因：外界修改了字符串，不会影响里面
 */
@implementation UIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"picker",@"自定义Picker",@"通讯录",@"文件存储",
                   @"个人主页",@"通用模板",@"手动modal",@"启动超级变换形态",@"拖拽事件"];
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
        AddressBoolLoginVC *vc = [[AddressBoolLoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3){
       FilesVC *vc = [[FilesVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
        SelfPageVC *vc = [[SelfPageVC alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==5){
        TemplateVC *vc =  [[UIStoryboard storyboardWithName:@"template" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TemplateVC"];
//        TemplateVC *vc = [[TemplateVC alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==6){
        //当在modal时，会吧窗口上面的view给移除，然后要modal控制器的view，给添加到窗口上
        
        
        
        //vc会被销毁
        //当应该控制器被销毁，那么它view的业务逻辑是没有办法处理的，需要一个强指针引用
        ModalVC *vc = [ModalVC new];
        //强应用，使view上业务可以继续
        self.modalVC = vc;
        CGRect rect = vc.view.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        vc.view.frame = rect;
        //强指针引用，view不会销毁，控制器被销毁，view不一定会被销毁
        [[UIApplication sharedApplication].keyWindow addSubview:vc.view];
        [UIView animateWithDuration:0.5 animations:^{
            vc.view.frame = self.view.frame;
        }completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
        
        
//        self.presentedViewController会强引用vc，所以view上业务还可以继续
        
//        [self presentViewController:vc animated:YES
//            completion:^{
//                
//        }];
    }else if(indexPath.row ==7){
        TransformVC *vc = [[TransformVC alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 8){
        DragVC *vc = [[DragVC alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==9){
        
    }else if (indexPath.row==10){
        
    }else if (indexPath.row==11){
       
    }else if (indexPath.row==12){
       
    }else if (indexPath.row==13){
        
    }
    
}


@end
