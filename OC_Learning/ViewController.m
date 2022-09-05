//
//  ViewController.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

#import "ViewController.h"
#import "ThreadVC.h"
#import "NetWorkVC.h"
#import "runtimeVC.h"
#import "OtherVC.h"
#import "LocationVC.h"
#import "UIVC.h"


#pragma  mark - controller
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *array;
@end

@implementation ViewController
- (IBAction)myBUtton:(id)sender {
    
}
//当控制器加载完毕时调用

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.array = @[@"多线程",@"网络",@"RunTime学习",@"其他",@"地图",@"UI"];
    [self.view addSubview:self.tableView];
}
//当控制器的view即将显示时调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}
//当控制器的view显示完毕时调用
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}
//当控制器的view将要布局子控件的时候调用
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__func__);
}

//当控制器的view布局子控件完毕的时候调用
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__func__);
}
//当控制器的view即将消失时调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}
//当控制器的view消失完毕时调用
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
        NetWorkVC *vc = [[NetWorkVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==2){
        runtimeVC *vc = [[runtimeVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==3){
        OtherVC *vc = [[OtherVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==4){
        LocationVC *vc = [[LocationVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==5){
        UIVC *vc = [[UIVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    
    }else if (indexPath.row==6){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if(indexPath.row ==7){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row == 8){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==9){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==10){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==11){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==12){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row==13){
        ThreadVC *vc = [[ThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}


@end


