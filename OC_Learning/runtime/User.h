//
//  User.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, strong) NSString *profile_image_url;

@property (nonatomic, assign) BOOL vip;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger mbrank;

//@property (nonatomic, assign) NSInteger mbtype;
@end

NS_ASSUME_NONNULL_END
