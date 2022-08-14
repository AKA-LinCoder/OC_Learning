//
//  LinTimeMode.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/14.
//

#import "LinTimeMode.h"

@implementation LinTimeMode
+(instancetype) timeWithDict:(NSDictionary *)dict
{
    LinTimeMode *mode = [[LinTimeMode alloc] init];
    
    //KVC
//    [mode setValuesForKeysWithDictionary:dict];
    mode.code = dict[@"code"];
    mode.mesage = dict[@"message"];
    return mode;
}
@end
