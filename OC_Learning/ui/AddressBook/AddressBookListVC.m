//
//  AddressBookListVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/5.
//

#import "AddressBookListVC.h"
#import "AddressBookAddVC.h"

@interface AddressBookListVC ()<AddressBookAddVCDelegate>
@property(nonatomic,strong)NSMutableArray<AddressBookUserItem *> *dataArray;
@end

@implementation AddressBookListVC
- (NSMutableArray *)dataArray
{
    if(_dataArray == nil){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录",self.userName];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"注销" menu:nil];
    self.navigationItem.leftBarButtonItem = left;
    left.target = self;
    left.action = @selector(logout);
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"添加" menu:nil];
    self.navigationItem.rightBarButtonItem = right;
    right.target = self;
    right.action =@selector(add);
    
    
    
}

- (void)setUserItem:(AddressBookUserItem *)userItem
{
    NSLog(@"这是获取到的数据%@",userItem);
}


-(void)logout
{
    NSLog(@"%s",__func__);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要退出么" message:nil preferredStyle:UIAlertControllerStyleActionSheet ] ;
    UIAlertAction* actionDefault = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
       }];
       
       
       UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       }];
       [alertController addAction:actionDefault];
       [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)add
{
    NSLog(@"%s",__func__);
    AddressBookAddVC *vc = [[AddressBookAddVC alloc] init];
    vc.listVC = self;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row].name;
    cell.detailTextLabel.text = self.dataArray[indexPath.row].phone;
    return cell;
}

/// 通过代理进行逆传值
- (void)addContactVC:(AddressBookAddVC *)addContactVC userItem:(AddressBookUserItem *)userItem
{
    [self.dataArray addObject:userItem];
    //刷新表格
    [self.tableView reloadData];
    NSLog(@"这是传递过来的item%@",userItem.name);
}



@end
