//
//  DateTextF.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "DateTextF.h"

@implementation DateTextF

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void) setUp
{
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //监听日期改变
    [picker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //日期键盘
    self.inputView = picker;
}

-(void) dateChange:(UIDatePicker *)picker
{
    //当前的日期给文本框赋值
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.text = [fmt stringFromDate:picker.date];
}


@end
