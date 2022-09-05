//
//  ProvinceTextF.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/5.
//

#import "ProvinceTextF.h"
#import "ProvinceItem.h"

@interface ProvinceTextF()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSArray<ProvinceItem *> *dataArray;
@property(nonatomic,assign) NSInteger proIndex;
@property(nonatomic,strong) UIPickerView *picker;
@end

@implementation ProvinceTextF

- (NSArray *)dataArray
{
    if (_dataArray==nil) {
        NSString *path =  [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
       NSArray *array =   [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in array) {
           ProvinceItem *item =  [ProvinceItem itemWithDict:dict];
            [temp addObject:item];
        }
        _dataArray = temp;
    }
    return _dataArray;
}

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
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    self.inputView = picker;
    self.picker = picker;
}

-(void) initWithText
{
    [self pickerView:self.picker didSelectRow:0 inComponent:0];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return self.dataArray.count;
    }else{
        //当前选中省份决定
        ProvinceItem *item = self.dataArray[self.proIndex];
        return item.cities.count;
        return 5;
    }
       
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.dataArray[row].name;
    }else{
        return self.dataArray[self.proIndex].cities[row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.proIndex = row;
        //让第一列选中第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        //刷新数据
        [pickerView reloadAllComponents];
       
    }
    //取出当前选中省份
    ProvinceItem *item = self.dataArray[self.proIndex];
    NSString *provinceName = item.name;
    //获取第一列选中的行
    NSInteger  cityRow = [pickerView selectedRowInComponent:1];
    NSString *cityName =  item.cities[cityRow];
    self.text = [NSString stringWithFormat:@"%@-%@",provinceName,cityName];
}

@end
