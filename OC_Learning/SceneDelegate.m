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


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    //在iOS13后的写法
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setWindowScene:windowScene];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        [self.window makeKeyAndVisible];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        nav.title = @"Lin";
        [self.window setRootViewController:nav];
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
