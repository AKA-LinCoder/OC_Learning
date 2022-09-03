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
    
    //第三个参数：设置应用程序对象的名称UIApplication或者是他的子类，如果是nil,默认是UIApplication
    //第四个参数：
    //创建UIApplication对象，并设置他的代理
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

/*
 1.执行main函数
 2.执行UIApplcationMain
 3.开启事件循环（主运行循环，死循环：保障应用程序不退出
 4.加载info.plist文件（判断info里面有没有Main,如果有就会去加载Main.sb）
 5.应用程序启动完毕（通知代理应用程序启动完毕）
 */

/*
 如果有Main,他就会加载Main.sb
 先创建一个窗口
 把main。sb箭头指向的控制器，设为窗口的根控制器
 显示窗口（把窗口的根控制器的View，添加到窗口）
 */
