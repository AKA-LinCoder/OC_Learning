//
//  HitTest01VC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/9.
//

#import "HitTest01VC.h"
#import "blueView.h"
@interface HitTest01VC ()
@property (weak, nonatomic) IBOutlet blueView *blue;

@end

@implementation HitTest01VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.view.subviews);
    
}



@end
