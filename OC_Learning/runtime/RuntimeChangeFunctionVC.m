//
//  RuntimeChangeFunctionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "RuntimeChangeFunctionVC.h"

@interface RuntimeChangeFunctionVC ()

@end

@implementation RuntimeChangeFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //想要修改系统的方法时，只能使用runtime(交换方法)
    //1.给系统的方法添加分类
    //2.自己实现一个带有拓展功能的方法
    //3.交换方法
    
    
    /*
        需求：让UIImage加载图片，告诉我是否加载成功->使用runtime交换方法
     解决：1.自定义UIImage，弊端：每次使用都要导入；项目大了没法后期实现
        2.分类：不能使用，会覆盖原有方法
     只能使用runtime
     */
    //在分类中，最好不要重写系统方法，一旦重写，会把系统方法给干掉
//    UIImage *image = [UIImage lin_imageNamed:@"people"];
    UIImage *image = [UIImage imageNamed:@"people"];
}



@end
