//
//  NSDictionary+Property.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "NSDictionary+Property.h"

@implementation NSDictionary (Property)
//生成属性代码
- (void)createProperty
{
    NSMutableString *codes = [NSMutableString string];
    //遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        } else if ([value isKindOfClass:[NSArray class]]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }

        // @property (nonatomic, strong) NSString *source;
        
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}
@end
