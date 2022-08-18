//
//  StatusItem.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//设计模型有哪些属性=>字典
//KVC:模型中属性必须与字典Key一一对应
@interface StatusItem : NSObject
@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) NSInteger reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) BOOL isA;

@property (nonatomic, assign) NSInteger attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, strong) NSDictionary *user;
+ (instancetype) itemWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
