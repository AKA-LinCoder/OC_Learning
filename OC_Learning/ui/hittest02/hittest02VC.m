//
//  hittest02VC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/10.
//

#import "hittest02VC.h"
#import "addBtn.h"
@interface hittest02VC ()
@property (weak, nonatomic) IBOutlet addBtn *fatherBtn;

@end

@implementation hittest02VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)btnClick:(addBtn *)sender {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, -80, 100, 80);
    [btn setImage:[UIImage imageNamed:@"对话框"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"小孩"] forState:UIControlStateHighlighted];
    //默认位置超出了父视图范围不接受事件
    [sender addSubview:btn];
    sender.popBtn = btn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
