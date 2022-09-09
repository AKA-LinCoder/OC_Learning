//
//  SelfPageVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/7.
//

#import "SelfPageVC.h"
#import "UIImage+Image.h"
//#define imageHeight 200;
@interface SelfPageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *headerView;
@property(nonatomic,strong)UIView *toolView;
@property(nonatomic,assign) CGFloat offet;
@end
 CGFloat imageHeight = 200;
@implementation SelfPageVC
- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, imageHeight)];
        _headerView.backgroundColor = [UIColor redColor];
        [_headerView setClipsToBounds:YES];
//        _headerView.contentMode = UIViewContentModeScaleAspectFit;
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_headerView.frame];
        _headerView.image = [UIImage imageNamed:@"people"];
//        [_headerView addSubview:imageView];
        
    }
    return  _headerView;
}
- (UIView *)toolView
{
    if (_toolView == nil) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, imageHeight, [UIScreen mainScreen].bounds.size.width, 30)];
        _toolView.backgroundColor = [UIColor orangeColor];
       
    }
    return  _toolView;
}
- (UITableView *)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, imageHeight+30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(imageHeight+30))];
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
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.toolView];
    //1.凡是在导航条下面的scrollview,默认会设置偏移
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    //设置不需要默认偏移量
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //让导航条隐藏
//    [self.navigationController.navigationBar setHidden:YES];
    //设置导航条透明度,之前没有效果，但是现在有效果
//    self.navigationController.navigationBar.alpha = 0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"haha" menu:nil];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init] ];
    //导航条设置背景
//    self.navigationController.navigationBar setba
    
    
//    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    NSLog(@"%f",self.view.frame.size.width);
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
//    self.tableView.translatesAutoresizingMaskIntoConstraints = YES;

//    self.tableView.tableHeaderView = imageView;
//    self.tableView.autoresizingMask = NO;
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"lin";
    [title sizeToFit];
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.navigationItem.titleView = title;
    
}
//监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //求偏移量=当前点-最原始的点
   
    self.offet = scrollView.contentOffset.y;
    CGFloat h = imageHeight-self.offet;
//    [[self.headerView.heightAnchor constraintEqualToConstant:h] setActive:YES];
//    [[self.headerView.heightAnchor constraintEqualToConstant:40] setActive:true];
    if(h<91){
        h = 91;
    }
    CGRect rect = self.headerView.frame;
    rect.size.height = h;
    NSLog(@"%f",h);
    self.headerView.frame = rect;
    CGRect rect2 = self.toolView.frame ;
    rect2.origin.y = h;
    self.toolView.frame = rect2;
    CGRect rect3 = self.tableView.frame ;
    rect3.origin.y = h+30;
    rect3.size.height = [UIScreen mainScreen].bounds.size.height-(h+30);
    self.tableView.frame = rect3;
    //根据透明度来生成图片
    //找最大值
    CGFloat alpha = self.offet*1 / 109.0;
    if(alpha>=1){
        alpha = 0.99;
    }
    //修改导航条背景图片/或者透明度
//    self.navigationController.navigationBar.alpha = alpha;
    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    //设置标题
    UILabel *title = (UILabel *)self.navigationItem.titleView;
   
    title.textColor = [UIColor colorWithWhite:0 alpha:alpha];
  
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
    return 100;
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
