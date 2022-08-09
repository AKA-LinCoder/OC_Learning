//
//  PthreadVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/9.
//

#import "PthreadVC.h"
#import "pthread.h"

@interface PthreadVC ()
@property(nonatomic,strong)UIButton *button;
@end

@implementation PthreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view.
}

- (UIButton *)button
{
    if(!_button){
        _button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
        [_button setTitle:@"pthread" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor orangeColor];
        [_button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}



/// pthread创建线程
/// @param button pthread按钮
- (void)tapButton:(UIButton *)button
{

    //创建线程对象
    pthread_t thread;
    //2.创建线程
    pthread_create(&thread, NULL,task, NULL);
}



//线程执行任务
void *task(void *param)
{
    NSLog(@"%@",[NSThread currentThread]);
    return NULL;
}

@end
