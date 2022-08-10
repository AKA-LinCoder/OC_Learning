//
//  LinTool.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinTool : NSObject<NSCopying,NSMutableCopying>
//提供一个类方法，可以方便外界访问，表明身份
+ (instancetype)sharedTool;
@end

NS_ASSUME_NONNULL_END
