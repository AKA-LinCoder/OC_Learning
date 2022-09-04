//
//  FlagItem.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "FlagItem.h"

@implementation FlagItem
+ (instancetype)itemWithDic:(NSDictionary *)dict
{
    FlagItem *item = [[FlagItem alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
