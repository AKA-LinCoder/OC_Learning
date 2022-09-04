//
//  FlagItem.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlagItem : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *icon;

+(instancetype) itemWithDic:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
