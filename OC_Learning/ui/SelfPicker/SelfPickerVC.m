//
//  SelfPickerVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "SelfPickerVC.h"
#import "FlagTextF.h"
#import "DateTextF.h"
#import "ProvinceTextF.h"
@interface SelfPickerVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FlagTextF *countryTextF;
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
    return YES;
}

//开始编辑时调用
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //让当前编辑的文本选中第一个
    if ([textField isKindOfClass:[FlagTextF class]]) {
        FlagTextF *field = (FlagTextF *)textField;
        [field initWithText];
    }else if ([textField isKindOfClass:[DateTextF class]]){
        DateTextF *field = (DateTextF *)textField;
        [field initWithText];
    }else if ([textField isKindOfClass:[ProvinceTextF class]]){
        ProvinceTextF *field = (ProvinceTextF *)textField;
        [field initWithText];
    }else{
        
    }
    //另一种实现
    /*
     创建一个新的分类，分类里面定义initWithText，并不需要实现，因为OC运行时会去寻找真正的方法，这里定义只是为了编译时不报错
     */
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
