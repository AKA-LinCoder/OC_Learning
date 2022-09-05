

#import <Foundation/Foundation.h>

@interface ProvinceItem : NSObject

/** 当前省份下的城市 */
@property (nonatomic, strong) NSArray *cities;

/** 省份的名称 */
@property (nonatomic, strong) NSString *name;

//快速的把字典转成模型
+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
