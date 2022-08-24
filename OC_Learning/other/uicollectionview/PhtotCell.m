//
//  PhtotCell.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/24.
//

#import "PhtotCell.h"

@interface PhtotCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhtotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

@end
