//
//  LinAPP.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "LinAPP.h"

@implementation LinAPP
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    LinAPP *appM = [[LinAPP alloc] init];
    //使用KVC
    [appM setValuesForKeysWithDictionary:dict];
    return  appM;
}
@end
