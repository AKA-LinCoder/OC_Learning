//
//  ViewController.m
//  OC_Learning
//
//  Created by lsaac on 2022/7/27.
//

#import "ViewController.h"
#import "PthreadVC.h"
#import "NSThreadVC.h"




#pragma  mark - controller
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *array;
@end

@implementation ViewController
- (IBAction)myBUtton:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.获取主线程
    NSThread *mainThread = [NSThread mainThread];
    NSLog(@"%@",mainThread);
    //2.获取当前线程
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"%@",currentThread);
    self.array = @[@"pthread",@"NSThread",@"GCD",@"NSOperation"];
    [self.view addSubview:self.tableView];
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
        PthreadVC *vc = [[PthreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
       
    }else if(indexPath.row==1){
        NSThreadVC *vc = [[NSThreadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}


@end


