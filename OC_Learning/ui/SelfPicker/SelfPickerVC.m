//
//  SelfPickerVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "SelfPickerVC.h"

@interface SelfPickerVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *countryTextF;
@property (weak, nonatomic) IBOutlet UITextField *birthDayTextF;
@property (weak, nonatomic) IBOutlet UITextField *cityTextF;

@end

@implementation SelfPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.countryTextF.delegate = self;
    self.birthDayTextF.delegate = self;
    self.cityTextF.delegate = self;
}

//是否运行编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

//开始编辑时调用
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
//是否运行结束编译
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
//结束编辑时
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
//是否运行改变文本框内容(拦截用户输入)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end
