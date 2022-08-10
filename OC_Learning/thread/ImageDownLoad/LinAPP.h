//
//  LinAPP.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinAPP : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *download;
+(instancetype) appWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
