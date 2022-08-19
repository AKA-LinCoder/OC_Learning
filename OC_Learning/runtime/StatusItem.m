//
//  StatusItem.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "StatusItem.h"

@implementation StatusItem
+ (instancetype) itemWithDict:(NSDictionary *)dict
{
    StatusItem *item = [StatusItem new];
    //KVC:把字典中的所有值给模型的属性赋值，弊端：必须一一对应
    [item setValuesForKeysWithDictionary:dict];
    //MJExtension：使用runtime：可以把一个模型中所有属性遍历出来
    //
    
    
    //KVC原理
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
//        [item setValue:value forKey:key];
//    }];
    
    return item;
}
/*
 [item setValue:value forKey:key];
 首先去模型中找有没有setXXX,找到，直接调用[self setXXX:@"aaa"]
 去模型中查找有没有xxx属性，有，直接访问属性 xxx=value
 去模型中查找有没有_xxx属性，有，直接访问属性 _xxx = value
 找不到：报错
 */
//重写系统方法：1.想添加额外的功能2.不想要系统方法实现
//系统找不到就会调用这个方法报错，所以可以重写这个方法不去报错
//这种方式解决KVC一一对应问题的存在的弊端：只能一级转换，不能处理其他的层级
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



@end
