//
//  LinTimeMode.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinTimeMode : NSObject
@property(nonatomic,strong) NSString *data;
@property(nonatomic,strong) NSNumber *code;
@property(nonatomic,strong) NSString *mesage;



+(instancetype)timeWithDict:(NSDictionary *)dict;
@end


NS_ASSUME_NONNULL_END
