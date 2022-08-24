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

- (CacultorManager *)add:(int)value
{
    _result += value;
    NSLog(@"当前总数是%ld",_result);
    return self;
}
- (CacultorManager * _Nonnull (^)(int))plus
{
    return ^(int value){
        _result += value;
        return self;
    };
}
@end
