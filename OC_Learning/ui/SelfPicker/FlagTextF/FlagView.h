//
//  FlagView.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import <UIKit/UIKit.h>
#import "FlagItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface FlagView : UIView
+(instancetype) flagView;
@property(nonatomic,strong) FlagItem *item;
@end

NS_ASSUME_NONNULL_END
