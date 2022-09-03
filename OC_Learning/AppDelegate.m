//
//  AppDelegate.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

/*
 一个IOS程序启动后创建的第一个对象就是UIApplication对象
 UIApplication:
    设置应用程序右上角红色提醒
    设置联网的状态
    设置状态栏,IOS 13 statusBarManager
    打开网页
 
 */
#import "AppDelegate.h"
#import <SDWebImage/SDWebImage.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

///应用程序启动完毕时调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置提醒图标
    UIApplication *app =  [UIApplication sharedApplication];
    //1.注册用户通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [app registerUserNotificationSettings:settings];
    app.applicationIconBadgeNumber = 10;
    //设置联网状态
    app.networkActivityIndicatorVisible = YES;
    //设置状态栏
    app.statusBarHidden = YES;
    [app openURL:[NSURL URLWithString:@"tel://10086"] options:nil completionHandler:^(BOOL success) {
        
    }];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

////当app失去焦点时调用
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}
///进入后台时调用
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}
///进行前台

///app获取焦点，焦点：能否交互
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

/// 当内存警告时
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //1.清空缓存
    //clearDisk:清除过期(7天 "SDImageCacheConfig.h")缓存，计算当前缓存的大小，和设置的最大缓存数，如果超出会继续删除(按照文件创建的时间)
    //cleanDisk: 全删
    //以上已经找不到相关设置
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeAll completion:^{
        
    }];
    //2.取消当前所有操作
    [[SDWebImageManager sharedManager] cancelAll];
    
    /**
                SDWebImageManager
        SDImageCache                   SDWebImageDownloader
                        SDWebImageDwonloaderOpertion
     */
    
    //3.最大并发数量
    //_maxConcurrentDownloads = 6; SDWebImageDownloaderConfig中
    //
    //4.缓存文件的保持名称如何处理
    //对图片地址进行MD5加密,mac终端可以对文本进行md5加密，echo -n "要加密的文本" ｜md5
    //5.该框架内部对内存警告的处理方法
    //内部监听通知 #import "SDMemoryCache.h"
    //6.队列中任务执行顺序
    //SDWebImageDownloaderFIFOExecutionOrder；SDWebImageDownloaderConfig中
    //7.该框架进行缓存处理的方式
    //字典-->NSCache
    //8.如果判断图片的类型
    //将文件图片变为二进制数据，再匹配第一个字节(四位) #import "NSData+ImageContentType.h"
    //9.如何下载图片的
    //发送网络请求，IOS9之前 NSURLConnection iOS9之后 NSURLSession   #import "SDWebImageDownloaderOperation.h"
    //10.请求超时时间
    //15s SDWebImageDownloaderConfig中
}

@end
