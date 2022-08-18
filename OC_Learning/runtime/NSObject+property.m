//
//  NSObject+property.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "NSObject+property.h"
#import <objc/message.h>

@implementation NSObject (property)

static NSString *_name;

- (void)setName:(NSString *)name
{
    //让这个字符串与当前对象产生联系
//    _name = name;
    
    /*
     objct:给哪个对象添加方法
     key:属性名称
     value：属性值
     policy:保存的策略
     */
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}
@end
