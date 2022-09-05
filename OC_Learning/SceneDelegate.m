//
//  SceneDelegate.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

#import "SceneDelegate.h"
#import "ViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate
/*
 UIWindows：通常一个app至少有一个UIWindow，app启动后创建的第一个视图控件就是UIWindow
 */

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    //在iOS13后的写法
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setWindowScene:windowScene];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    //通过xib加载控制器的view,
    //initWithNibName如果制定了特定的名称的xob，会去加载指定的xib，如果是nil，会先判断有没有和当前控制器相同名称的xib如果有就加载（LinViewController.xib），如果没有，会自动加载和他名称相同，并去掉controller的(LinView.xib)
    //init底层会自动调用initWithNibName
    UIViewController *xxx = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    nav.title = @"Lin";
    [self.window setRootViewController:nav];
    NSLog(@"%@",self.window);
    //显示窗口
    [self.window makeKeyAndVisible];
//    NSLog(@"%@",self.window);
//    self.window.windowLevel = UIWindowLevelNormal;
//    //通过sb加载控制器
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *vcc = [sb instantiateInitialViewController];
//    self.window.rootViewController = vcc;
    
    //UItextField想要弹出键盘，必须添加到view上
    /*
     makeKeyAndVisible：
        设置应用程序的主窗口
        让窗口显示，把窗口hidden = no
        把窗口的根控制器的view添加到窗口上（self.window addSubView:rootViewController.view）
        
     */
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    
}


- (void)sceneWillResignActive:(UIScene *)scene {
    
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    
}


@end
