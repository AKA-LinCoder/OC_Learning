//
//  WheelView.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "WheelView.h"

@interface WheelView()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation WheelView

+ (instancetype)wheelView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)startRotation
{
    NSLog(@"%s",__func__);
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置属性
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI*3);
    anim.duration = 1;
    anim.repeatCount = MAXFLOAT;
    //添加动画
    
    [self.bgView.layer addAnimation:anim forKey:nil];
}

- (void)stopRotation
{
    
}
@end
