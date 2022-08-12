//
//  main.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



//入口函数
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
       
    }
    //内部启动runloop(其实就是死循环)
    //UIApplicationMain这个方法是有一个返回值的，但是永远不会返回，因为一旦返回就代表方法执行完毕，程序就死了，保持程序持续执行
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
