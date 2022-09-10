//
//  MyDrawerVCViewController.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/10.
//

#import "MyDrawerVCViewController.h"
#import "MainTabVC.h"
@interface MyDrawerVCViewController ()

@end

@implementation MyDrawerVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //当一个控制器的view添加到另一个控制器的view上的时候，那么此时view所在的控制器也应该成为上一个控制器的子控制器
    MainTabVC *vc1 = [[MainTabVC alloc] init];
    vc1.view.frame = self.mainView.frame;
    [self.mainView addSubview:vc1.view];
    [self addChildViewController:vc1];
    
    MainTabVC *vc2 = [[MainTabVC alloc] init];
    vc2.view.frame = self.leftView.frame;
    vc2.view.backgroundColor = [UIColor redColor];
    [self.leftView addSubview:vc2.view];
    [self addChildViewController:vc2];
    
}



@end
