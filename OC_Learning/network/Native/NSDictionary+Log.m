//
//  NSDictionary+Log.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/15.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
//重写系统的方法，控制输出
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    //拼接key,value
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@:",key];;
        [string appendFormat:@"%@,",obj];
    }];
    [string appendString:@"}"];
    
    //删除最后一个，
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if(range.location !=NSNotFound){
        [string deleteCharactersInRange:range];
    }
    return string;
}
@end

@implementation NSArray (Log)
//重写系统的方法，控制输出
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"["];
    //拼接object
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@,\n",obj];
    }];
    [string appendString:@"]"];
    //删除最后一个，
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if(range.location !=NSNotFound){
        [string deleteCharactersInRange:range];
    }
    return string;
}
@end
