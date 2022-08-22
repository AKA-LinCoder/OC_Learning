//
//  BlockVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "BlockVC.h"

@interface BlockVC ()

@end
/*
 block声明，定义，作用，类型，调用
 作用:保存一段代码
 声明:返回值(^block变量名)(参数)
 定义:
    1. =^(参数){}
    2. 如果没有参数，参数可以隐藏 =^{}，如果有参数，必须写参数，而且必须要有参数变量名
    3. =^int{} ,block的返回可以省略，不管有没有返回值，都可以省略
 类型: 等号左边去掉变量名的就是类型
 调用：变量名()
 快捷方式:输入inli
 */
@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    void(^block)();
    
    //定义
    void(^block1)() = ^(){};
    
    int(^block3)() = ^int{
        return 3;
    };
    block();
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
