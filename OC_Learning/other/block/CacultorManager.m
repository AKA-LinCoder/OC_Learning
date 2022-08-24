//
//  CacultorManager.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/24.
//

#import "CacultorManager.h"

@implementation CacultorManager
- (void)cacultor:(NSInteger (^)(NSInteger))block
{
    if(block){
        _result = block(_result);
    }
}
@end
