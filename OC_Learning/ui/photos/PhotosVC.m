//
//  PhotosVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/12.
//

#import "PhotosVC.h"
#import "watermarkVC.h"
#import "screenshootVC.h"

@interface PhotosVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation PhotosVC
- (UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.dataArray = @[@"图片添加水印",@"截屏"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        watermarkVC *vc = [watermarkVC new];
        vc.navigationItem.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        screenshootVC *vc = [screenshootVC new];
        vc.navigationItem.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
