//
//  CacultorManager.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacultorManager : NSObject
@property(nonatomic,assign) NSInteger result;
-(void) cacultor:(NSInteger(^)(NSInteger result))block;
-(CacultorManager *) add:(int)value;
-(CacultorManager *(^)(int)) plus;
@end

NS_ASSUME_NONNULL_END
