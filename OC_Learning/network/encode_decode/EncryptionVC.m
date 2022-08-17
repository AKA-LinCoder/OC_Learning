//
//  EncryptionVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/17.
//

#import "EncryptionVC.h"

@interface EncryptionVC ()

@end

@implementation EncryptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//对字符串进行base64编码
-(NSString*)base64EncodeString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

-(NSString*)base64DecodeString:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
