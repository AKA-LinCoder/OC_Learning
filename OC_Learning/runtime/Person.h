//
//  Person.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCoding,NSSecureCoding>
@property(nonatomic,strong)NSString *name;
-(void) eat;
//-(void) run:(NSInteger)m;
-(void)test;
@end

NS_ASSUME_NONNULL_END
