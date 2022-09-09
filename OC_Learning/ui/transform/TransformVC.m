//
//  TransformVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "TransformVC.h"

@interface TransformVC ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation TransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)moveDown:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
    //相对上一次形变
        self.image.transform = CGAffineTransformTranslate(self.image.transform, 0, 10);
    }];
}
- (IBAction)moveUp:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        //使用make，他是相对于最原始的位置做的形变
//            self.image.transform = CGAffineTransformMakeTranslation(0, -100);
    //相对上一次形变
        self.image.transform = CGAffineTransformTranslate(self.image.transform, 0, -100);
    }];
}
- (IBAction)rotation:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
          //旋转，旋转的度数，是一个弧度
//        self.image.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.image.transform = CGAffineTransformRotate(self.image.transform, M_PI_4);
    }];
}
- (IBAction)scale:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        
//        self.image.transform = CGAffineTransformMakeScale(1.2, 1);
        self.image.transform = CGAffineTransformScale(self.image.transform, 0.8, 0.8);
    }];
}

@end
