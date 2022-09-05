

#import "ProvinceItem.h"

@implementation ProvinceItem

+ (instancetype)itemWithDict:(NSDictionary *)dict{
    
    ProvinceItem *item =  [[ProvinceItem alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
