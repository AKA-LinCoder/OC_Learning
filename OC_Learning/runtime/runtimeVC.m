//
//  runtimeVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "runtimeVC.h"
#import <objc/message.h>
#import "Person.h"
#import "RuntimeChangeFunctionVC.h"
#import "runtimeKVCVC.h"

@interface runtimeVC ()
@property(nonatomic,strong)NSArray *array;
@end

@implementation runtimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"runtime交换方法",@"runtimeKVC",@"线程安全",@"NSThread线程间通信",@"GCD",@"GCD线程间通信",@"GCD队列组",@"NSOperation",@"NSOperation线程通信",@"多图下载",@"SDWebImages",@"NSCache",@"RunLoop",@"RunLoop应用(线程常驻)"];
    //id:谁发送消息
    //SEL：发送什么消息
//    id objc = ((NSObject *(*)(id,SEL))(void *)objc_msgSend)([NSObject class],@selector(alloc));
//    //Xcode6之后不推荐使用runtime
//    //build_setting ->搜objc_msg -> no
//    id objc3 = [NSObject alloc];
//    id objc2 = objc_msgSend([NSObject class], @selector(alloc));
//    objc2 = [objc2 init];
//    objc2 = objc_msgSend(objc2, @selector(init));
    
    //1.分配内存
    Person *people = [Person alloc];
    //2.初始化
    people = [people init];
    [people eat];
    //转为runtime
    //[Person class] == objc_getClass("Person")
    //@selector(alloc) == sel_registerName("alloc")
//    Person *people2 = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
//    people2 = objc_msgSend(people2, sel_registerName("init"));
//    objc_msgSend(people2, sel_registerName("eat"));
    
    
    //后面可以跟很多个参数
//    objc_msgSend(people2, @selector(run:),20);
    //方法调用流程
    //怎么去调用eat方法，，对象方法保存在类对象的方法列表中，类方法保存在元类的方法列表中，方法的实现没有保存在类中，而是保存在方法区
    //内存5大区：1.栈 2.堆 3.静态区 4.常量区 5.方法区
    //栈：不需要手动管理内存，自动管理
    //堆：需要手动管理内存，自己去释放

    //1.去寻找对应的类对象， 通过isa指针去对应的类中查找
    //2.注册方法编号
    //3.根据方法编号查找对应方法
    //4.找到的只是最终函数实现的地址，根据地址去方法区调用函数
    
    
    
    
    
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
        RuntimeChangeFunctionVC *vc = [[RuntimeChangeFunctionVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
        runtimeKVCVC *vc = [[runtimeKVCVC alloc] init];
              [self presentViewController:vc animated:YES completion:nil];
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
