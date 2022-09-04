//
//  PickerVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "PickerVC.h"

@interface PickerVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong) NSArray *array;
@end

@implementation PickerVC

- (NSArray *)array
{
    if(_array == nil){
       NSString *path = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        _array = [NSArray arrayWithContentsOfFile:path];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置数据源
    self.picker.dataSource = self;
    //设置代理
    self.picker.delegate = self;
    //默认选中第0个
    [self pickerView:self.picker didSelectRow:0 inComponent:0];
}
//总共多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.array.count;
}
//多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *data = self.array[component];
    return data.count;
}
////每一列宽度
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    return 50;
//}
////每一行高度
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 50;
//}
//每一行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *data = self.array[component];
    
    return data[row];
}

//每一行展示什么内容
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    return [UIButton buttonWithType:UIButtonTypeClose];
//}
//当前选中的是那一列哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *data = self.array[component];
    self.titleLabel.text = data[row];
}

@end
