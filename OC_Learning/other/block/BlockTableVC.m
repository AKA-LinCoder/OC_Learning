//
//  BlockTableVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/23.
//

#import "BlockTableVC.h"
#import "CellItem.h"



@interface BlockTableVC ()
@property(nonatomic,strong)NSArray<CellItem *> *array;
@end

@implementation BlockTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CellItem *item = [CellItem itemWithTitle:@"打电话"];
    item.block = ^{
        NSLog(@"我要开始打电话");
    };
    CellItem *item2 = [CellItem itemWithTitle:@"发短信"];
    item2.block = ^{
        NSLog(@"我要开始发短信");
    };
    CellItem *item3 = [CellItem itemWithTitle:@"发邮件"];
    item3.block = ^{
        NSLog(@"我要开始发邮件");
    };
    self.array = @[item,item2,item3];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _array[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //把要做的事情(代码)保存到模型
    _array[indexPath.row].block();
    if ([_delegate respondsToSelector:@selector(BlockTableVC:sendValue:)]) {
        [_delegate BlockTableVC:self sendValue:@"这是反方向的值"];
    }
    
    
}



@end
