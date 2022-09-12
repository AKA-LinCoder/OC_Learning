//
//  unlockVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "unlockVC.h"
#import "clockView.h"

@interface unlockVC ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)clockView *passwordView;
@end

@implementation unlockVC
- (UIImageView *)imageView
{
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _imageView.image = [UIImage imageNamed:@"Home_refresh_bg"];
    }
    return _imageView;
}

- (UIView *)passwordView
{
    if(_passwordView==nil)
    {
        _passwordView = [[clockView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _passwordView.center = self.view.center;
        _passwordView.backgroundColor = [UIColor redColor];
    }
    return _passwordView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.passwordView];
}



@end
