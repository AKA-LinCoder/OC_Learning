//
//  FlagView.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "FlagView.h"

@interface FlagView()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation FlagView

+(instancetype) flagView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil] lastObject];
}

- (void)setItem:(FlagItem *)item
{
    _item = item;
    NSLog(@"%@",item.icon);
    //子控件赋值
    self.name.text = item.name;
//    self.icon.image = [UIImage imageNamed:@"people"];
    self.icon.image = [UIImage imageNamed:item.icon];
}



@end
