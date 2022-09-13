//
//  Canvas.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Canvas : UIView
-(void) clean;
-(void) reback;
-(void)setLineColor:(UIColor *)color;
-(void)setLineWidth:(CGFloat )width;
-(void)eraser;
@end

NS_ASSUME_NONNULL_END
