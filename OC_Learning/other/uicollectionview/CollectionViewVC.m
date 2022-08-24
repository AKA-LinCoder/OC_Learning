//
//  CollectionViewVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/24.
//

#import "CollectionViewVC.h"
#import "PhtotCell.h"
@interface CollectionViewVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"特么的";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

-(void) setupUI
{
    //UIcollectionView使用步骤
    //1.必须有个布局参数
    //2.cell必须注册
    //3.cell必须自定义，默认啥都没有
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor orangeColor];
//        collectionView.center = self.view.center;
    collectionView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-200)*0.5, [UIScreen mainScreen].bounds.size.width, 200);

    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib: [UINib nibWithNibName:NSStringFromClass([PhtotCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    
    
}
#pragma mark-UICollectionViewDelegate

#pragma mark-UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhtotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PhtotCell alloc] init];
    }
    cell.image = [UIImage imageNamed:@"people"];
    return cell;
}
@end
