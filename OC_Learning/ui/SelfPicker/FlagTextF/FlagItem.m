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
//    [item setValuesForKeysWithDictionary:dict];
//    item.icon = [UIImage imageNamed:item.icon];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [item setValue:obj forKey:key];
    }];
    
    /*
     setValue:forKey
     首先查看有没有对应key值的set方法，如果有，就调用
     如果没有对应的set方法，就会去查看有咩用跟key值相同并且带有下划线属性，如果有，就给这个带下划线的赋值
     如果没有跟key值相同且带有下划线的成员属性，还会去找有没有根key值相同的成员属性，如果有就给他赋值
     再没有就直接报错
     */
    
    return item;
}

- (void)setIcon:(UIImage *)icon
{
    NSString *name = (NSString *)icon;
    _icon =  [UIImage imageNamed:name];
}
@end
