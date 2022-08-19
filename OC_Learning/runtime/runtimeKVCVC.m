//
//  runtimeKVCVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "runtimeKVCVC.h"
#import "NSDictionary+Property.h"
#import "StatusItem.h"
#import "NSFileManager+Additions.h"
#import "NSObject+Model.h"
@interface runtimeKVCVC ()

@end

@implementation runtimeKVCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
   NSDictionary *dict =  [NSDictionary dictionaryWithContentsOfFile:fullPath];
//    [dict createProperty];
    //字典转模型
    StatusItem *item = [StatusItem modelWithDice:dict];
//    [NSTemporaryDirectory() stringByAppendingPathComponent:@"haha"];
    NSLog(@"%@",item.user);
}



@end
