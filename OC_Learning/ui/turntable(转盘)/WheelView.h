//
//  WheelView.h
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WheelView : UIView
+(instancetype)wheelView;
-(void) startRotation;
-(void) stopRotation;
@end

NS_ASSUME_NONNULL_END
