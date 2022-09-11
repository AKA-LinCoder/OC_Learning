//
//  SelfImageView.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelfImageView : UIView
@property(nonatomic,strong)UIImage *image;
-(instancetype)initWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
