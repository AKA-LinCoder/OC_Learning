//
//  CollectionViewVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/24.
//

#import "CollectionViewVC.h"
#import "PhtotCell.h"
#import "FlowLayout.h"
#define ScreenW  [UIScreen mainScreen].bounds.size.width
#define ScreenH  [UIScreen mainScreen].bounds.size.height
@interface CollectionViewVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@end

@implementation CollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"特么的";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLayout];
    [self setupCollectionViewUI];
}
//函数式编程：把很多功能放在一个函数块block去处理
//低耦合高聚合
-(void)setupLayout
{
    FlowLayout *layout = ({
        FlowLayout *layout = [[FlowLayout alloc]init];
        layout.itemSize = CGSizeMake(160, 160);
        layout.minimumLineSpacing = 50;//行间距
        CGFloat margin = (ScreenW-160)*0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    //    layout.minimumInteritemSpacing = 0;//最小item间距
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout;
    });
    self.layout = layout;
}

-(void) setupCollectionViewUI
{
    //UIcollectionView使用步骤
    //1.必须有个布局参数
    //2.cell必须注册
    //3.cell必须自定义，默认啥都没有
    
    
 

    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        collectionView.showsHorizontalScrollIndicator = NO;
        
        collectionView.backgroundColor = [UIColor orangeColor];
        
        NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
        NSLog(@"%f",self.view.bounds.size.width);
        collectionView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-200)*0.5, [UIScreen mainScreen].bounds.size.width, 200);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib: [UINib nibWithNibName:NSStringFromClass([PhtotCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
        collectionView;
        
    });
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
