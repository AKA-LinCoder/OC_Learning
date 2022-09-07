//
//  SelfPageVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/7.
//

#import "SelfPageVC.h"

@interface SelfPageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SelfPageVC
- (UITableView *)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人主页";
    [self.view addSubview:self.tableView];
    //1.凡是在导航条下面的scrollview,默认会设置偏移
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    //设置不需要默认偏移量
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //让导航条隐藏
//    [self.navigationController.navigationBar setHidden:YES];
    //设置导航条透明度,之前没有效果，但是现在有效果
    self.navigationController.navigationBar.alpha = 0.5;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"haha" menu:nil];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init] ];
    //导航条设置背景
//    self.navigationController.navigationBar setba
    
    
//    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.adjustedContentInset));
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     下面两种的区别：要使用indexpath，就必须register,而且就不用判断下面cell是否为nil了，如果使用上面的就不需要上面注册
     */
//    UITableViewCell *m = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//    }
    cell.textLabel.text = @"234567";
    return cell;
}

@end
