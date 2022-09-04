//
//  FlagTextF.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/4.
//

#import "FlagTextF.h"
#import "FlagItem.h"
#import "FlagView.h"
@interface FlagTextF()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSArray<FlagItem *> *dataArray;
@end


@implementation FlagTextF

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray<FlagItem *> *temp = [NSMutableArray array];
        for (NSDictionary * dict in array) {
            FlagItem *item = [FlagItem itemWithDic:dict];
            [temp addObject:item];
        }
        _dataArray = temp;
    }
    return _dataArray;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

//初始化文本框
-(void) setup
{
    //创建UIPickView
    UIPickerView *pick = [[UIPickerView alloc]init];
    pick.delegate = self;
    pick.dataSource = self;
    //修改文本框弹出键盘类型
    self.inputView = pick;
}

//实现协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    FlagView *flagView =  [FlagView flagView];
//    //取出模型
    FlagItem *item =  self.dataArray[row];
    flagView.item = item;
    return flagView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}
//当前选中内容显示到文本框
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    FlagItem *item =  self.dataArray[row];
    self.text = item.name;
}
@end
