//
//  truntableVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/15.
//

#import "truntableVC.h"
#import "WheelView.h"
@interface truntableVC ()
@property(nonatomic,strong) UIButton *stopBtn;
@property(nonatomic,strong) UIButton *startBtn;
@property(nonatomic,strong) WheelView *wheelView;
@end

@implementation truntableVC
- (UIButton *)stopBtn
{
    if(_stopBtn==nil){
        _stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 150, 10, 10)];
        [_stopBtn setTitle:@"暂停" forState:UIControlStateNormal];

        [_stopBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
        [_stopBtn sizeToFit];
        [_stopBtn addTarget:self action:@selector(stopRun) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}


- (UIButton *)startBtn
{
    if(_startBtn==nil){
        _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 10, 10)];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal ];
        [_startBtn sizeToFit];
        [_startBtn addTarget:self action:@selector(startRun) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WheelView *wheelView = [WheelView wheelView];
    
    wheelView.center = self.view.center;
    self.wheelView = wheelView;
    [self.view addSubview:wheelView];
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.stopBtn];
    
}


/// 开始旋转
-(void) startRun
{
    [self.wheelView startRotation];
}

/// 暂停旋转
-(void) stopRun
{
    [self.wheelView stopRotation];
}


@end
