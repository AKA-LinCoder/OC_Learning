//
//  ScrollviewAutoLayoutVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "ScrollviewAutoLayoutVC.h"
/*
 UIScrollView做自动布局：首先确定scrollview滚动范围=>如何在starboard对scrollview确定滚动范围=>搞一个专门的view去确定scrollview的滚动范围=>如果确定水平和垂直方向=>scrollview水平是否能滚动：view的宽度+左右两边间距 才能确定scrollview水平滚动区域=>view的高度+上下间距
 
 https://www.youtube.com/watch?v=5jm04dPwCP0
 */
@interface ScrollviewAutoLayoutVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLin;


@end

@implementation ScrollviewAutoLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleLin.text = @"Do any additional setup after loading the view from its nib";
    // Do any additional setup after loading the view from its nib.
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
