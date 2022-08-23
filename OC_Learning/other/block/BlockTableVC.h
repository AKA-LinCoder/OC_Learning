//
//  BlockTableVC.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/23.
//

#import <UIKit/UIKit.h>
@class BlockTableVC;
NS_ASSUME_NONNULL_BEGIN

@protocol BlockTableVCDelegate <NSObject>

@optional
-(void)BlockTableVC:(BlockTableVC *) vc sendValue:(NSString *)something;

@end
//设计方式：xiang

@interface BlockTableVC : UITableViewController
@property(nonatomic,weak) id<BlockTableVCDelegate> delegate;
@property(nonatomic,strong) void(^block)(NSString *value);
@end

NS_ASSUME_NONNULL_END
