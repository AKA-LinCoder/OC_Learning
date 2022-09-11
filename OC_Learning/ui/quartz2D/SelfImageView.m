//
//  SelfImageView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/11.
//

#import "SelfImageView.h"

@implementation SelfImageView

- (void)drawRect:(CGRect)rect
{
    [self.image drawInRect:rect];
}

//为了实现切换图片时展示不同图片
- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}
//创建imageview大小跟原始图片一样大
-(instancetype)initWithImage:(UIImage *)image
{
    if (self = [super init]) {
        //确定尺寸大小
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _image = image;
    }
    return  self;
}

@end
