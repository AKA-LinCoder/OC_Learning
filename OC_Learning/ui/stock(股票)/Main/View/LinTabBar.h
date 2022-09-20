//
//  LinTabBar.h
//  OC_Learning
//
//  Created by Estim on 2022/9/20.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@class LinTabBar;
@protocol LinTabBarDelegate <NSObject>

-(void)linTabBar:(LinTabBar *)tabBar index:(NSInteger)index;

@end

@interface LinTabBar : UIView
//@property(nonatomic,assign)NSInteger tabBarCount;
@property(nonatomic,strong)NSArray* items;
@property(nonatomic,weak)id<LinTabBarDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
