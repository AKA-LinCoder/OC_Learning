//
//  ImageFoldVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "ImageFoldVC.h"

@interface ImageFoldVC ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;

@end

@implementation ImageFoldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //让上面图片只显示上面，下面图片只显示下面
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 0);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
            self.topImageV.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    }];
}

@end
