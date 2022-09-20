//
//  ArenaVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/19.
//

#import "ArenaVC.h"

@interface ArenaVC ()
@property(nonatomic,strong)UILabel *label;
@end

@implementation ArenaVC
- (UILabel *)label
{
    if (_label==nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
        _label.backgroundColor = [UIColor purpleColor];
        _label.text = @"我爱我家";
    }
    return _label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    // Do any additional setup after loading the view.
}



@end
