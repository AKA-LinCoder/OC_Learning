//
//  NSObject+Model.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)
//本质：创建谁的对象
+(instancetype)modelWithDice:(NSDictionary *)dict
{
    id objc = [[self alloc] init];
    //runtime实现,根据模型中属性，去字典中取出对应的value给模型属性赋值
    //获取模型中的所有属性
    //成员变量：以下划线开头
    int count = 0;
    //获取成员变量数组
    Ivar *ivarList =  class_copyIvarList(self, &count);
    //遍历
    for(int i = 0;i<count;i++){
        //获取成员变量
        Ivar ivar = ivarList[i];
        //获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *ivalType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"ivalType111:%@",ivalType);
        ivalType = [ivalType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivalType = [ivalType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSString *key = [ivarName substringFromIndex:1];
        //去字典中查找对应的value
        id value =  dict[key];
        
        //二级转换,是字典且是自定义类型
        if([value isKindOfClass:[NSDictionary class]] && !
           [ivalType hasPrefix:@"NS"]){
            //字典转模型 userDict => User模型
            //转换成哪个模型
            //获取成员变量类型
            NSLog(@"ivalType:%@",ivalType);
            //字符串 -》类
            Class modelClass = NSClassFromString(ivalType);
            NSLog(@"%@",modelClass);
            value = [modelClass modelWithDice:value];
        }
        if(value){
            [objc setValue:value forKey:key];
        }
       
    }
    //根据属性名去字典中查找value
    //给模型中属性赋值
    return objc;
}


////获取类中所有方法
//class_copyMethodList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
//获取类里的属性
//class_copyPropertyList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
@end
