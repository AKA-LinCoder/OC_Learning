//
//  DrawerVC.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawerVC : UIViewController
@property(nonatomic,weak,readonly)UIView *leftView;
@property(nonatomic,weak,readonly)UIView *mainView;
@property(nonatomic,weak,readonly)UIView *rightView;
@end

NS_ASSUME_NONNULL_END
