//
//  FlowLayout.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/24.
//

#import "FlowLayout.h"

@implementation FlowLayout
/*
 自定义布局：只要了解5个方法
 */

/// 计算cell布局，条件：cell的位置是固定不变的
/// 什么时候调用：collectionView第一次布局，collectionView刷新也会调用
//- (void)prepareLayout
//{
//    [super prepareLayout];
////    NSLog(@"%s",__func__);
//}

/// 计算滚动范围
//- (CGSize)collectionViewContentSize
//{
//    return [super collectionViewContentSize];
//}

/*
 UICollectionViewLayoutAttributes:确定cell尺寸
 一个UICollectionViewLayoutAttributes对象就对应一个cell
 拿到UICollectionViewLayoutAttributes相当于拿到cell
 */

//一次性返回所有cell尺寸
/// 返回很多cell的尺寸
/// @param rect 尺寸
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //设置cell尺寸
    //1.获取当前显示区域 self.collectionView.bounds
    //2.拿到当前显示cell的布局
    //3.越靠近中心点，距离越小， cell显示越大
    //4.求cell与中心点距离
    NSArray *arr =  [super layoutAttributesForElementsInRect:self.collectionView.bounds];
   
//    int i = 0;
    for (UICollectionViewLayoutAttributes *attr in arr) {
        //计算中心点距离 ,绝对值
        CGFloat delta =  fabs((attr.center.x-self.collectionView.contentOffset.x)-self.collectionView.bounds.size.width *0.5);
        //计算比例
        CGFloat scale = 1 -  delta/(self.collectionView.bounds.size.width *0.5)*0.25;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

/// 在滚动collectionview是否允许刷新布局
/// @param newBounds <#newBounds description#>
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/// 确定最终偏移量
/// 什么时候调用：用户手指一松开
/// @param proposedContentOffset <#proposedContentOffset description#>
/// @param velocity <#velocity description#>
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGFloat collectionW = self.collectionView.bounds.size.width;
    //拖动比较快时：最终偏移量 ！=手指偏移量
    //拖动比较慢时，相等
    //最终偏移量
    CGPoint point =  [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    //手指偏移量
//    CGPoint handle = self.collectionView.contentOffset;
//    NSLog(@"最终偏移量%@",NSStringFromCGPoint(point));
//    NSLog(@"手指偏移量%@",NSStringFromCGPoint(handle));
    
    /*
     确定最终偏移量
     距离中心点距离越近，最终cell就展示到中心点
     0.最终偏移量
     1.获取最终显示的区域
     2.获取最终显示的cell
     
     */
    //最终显示区域
    CGRect targetRect = CGRectMake(point.x, 0, collectionW, MAXFLOAT);
    //记录最小距离
    CGFloat minDelta = MAXFLOAT;
    //获取最终显示的cell
    NSArray *arr = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes *attr in arr) {
        //获取距离中心点距离
        CGFloat delta =  (attr.center.x-point.x)-self.collectionView.bounds.size.width *0.5 ;
        if (fabs(delta)<fabs(minDelta)) {
            minDelta = delta;
        }
    }
    point.x +=minDelta;
    if(point.x<0)
    {
        point.x = 0;
    }
    return point;
}

@end
