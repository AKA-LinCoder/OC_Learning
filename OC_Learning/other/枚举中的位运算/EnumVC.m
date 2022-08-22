//
//  EnumVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/22.
//

#import "EnumVC.h"

@interface EnumVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation EnumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.textField addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin|UIControlEventEditingDidEnd|UIControlEventEditingDidEndOnExit];
    int a = 1<<0;
    int b = 1<<1;
    int c = 1<<2;
    int d = 1<<3;
    [self test:a|c];
}

-(void) textBegin
{
    NSLog(@"%s",__func__);
}

-(void) test:(int) value
{   int a = 1<<0;
    int b = 1<<1;
    int c = 1<<2;
    int d = 1<<3;
    //解析value ,判断是否包含abc
    NSLog(@"%d,%d,%d,%d",value&a,value&b,value&c,value&d);
}

@end
