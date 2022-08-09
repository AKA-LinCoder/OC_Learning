//
//  main.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"




int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        printf("c hello");
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
       
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
