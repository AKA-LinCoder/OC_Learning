//
//  BlockTableVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/23.
//

#import "BlockTableVC.h"
#import "CellItem.h"



@interface BlockTableVC ()
@property(nonatomic,strong) void(^block1)();
@property(nonatomic,strong) void(^block2)();
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
    //1.会造成循环引用
//    _block1 = ^{
//        NSLog(@"%@",self);
//    };
    //解决循环引用
    __weak typeof(self) weakSelf = self;
    _block1 = ^{
        NSLog(@"%@",weakSelf);
    };
    //2.在block中使用延迟操作也可能会导致延迟操作无法执行
//    _block2 = ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"%@",weakSelf);
//        });
//    };
    //解决延迟方法无法执行的问题，创建强指针引用
  
    _block2 = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"hahahha%@",strongSelf);
        });
    };
    _block2();
    
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
    
    if (_block) {
        _block(@"哈哈哈哈");
    }
    //返回上一页，并销毁当前对象
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)dealloc
{
    NSLog(@"销毁了");
}


@end
