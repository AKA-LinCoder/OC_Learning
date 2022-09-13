//
//  HandleImageView.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HandleImageView;
@protocol handleImageViewDelegate <NSObject>

- (void)handleImageView:(HandleImageView *)handleImageView newImage:(UIImage *)newImage;

@end


@interface HandleImageView : UIView

/** <#注释#> */
@property (nonatomic, strong) UIImage *image;

/** <#注释#> */
@property (nonatomic, weak) id<handleImageViewDelegate> delegate;

@end
NS_ASSUME_NONNULL_END
