//
//  CellItem.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellItem : NSObject
@property(nonatomic,strong)NSString *title;
//保存每个cell做的事情
@property(nonatomic,strong) void(^block)(void);
+(instancetype) itemWithTitle:(NSString *) title;
@end

NS_ASSUME_NONNULL_END
