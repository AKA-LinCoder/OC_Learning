//
//  WebViewVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/16.
//

#import "WebViewVC.h"
#import <WebKit/WebKit.h>
@interface WebViewVC ()



@property(nonatomic,strong) WKWebView *webView;

@end

@implementation WebViewVC
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.frame = self.view.frame;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.view.backgroundColor = [UIColor orangeColor];
    [self test2];
}
-(void)test1
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
-(void)test2
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(40, 10, 0, 10);
    
//    if (@available(iOS 13.0, *)) {
//        self.webView.scalesLargeContentImage = YES;
//    } else {
//        // Fallback on earlier versions
//    }
    
}


@end
