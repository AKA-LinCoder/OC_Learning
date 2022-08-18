//
//  NSObject+property.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (property)
//只会生成get，set方法声明，不会生成实现，也不会生产下划线成员属性
@property NSString *name;
@end

NS_ASSUME_NONNULL_END
