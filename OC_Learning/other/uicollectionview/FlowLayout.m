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
- (void)prepareLayout
{
    [super prepareLayout];
//    NSLog(@"%s",__func__);
}

/// 计算滚动范围
- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

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
    NSArray *arr =  [super layoutAttributesForElementsInRect:rect];
    int i = 0;
    for (UICollectionViewLayoutAttributes *attr in arr) {
        
        if(i==0){
            attr.transform = CGAffineTransformMakeScale(0.5, 0.5);
        }
        i++;
    }
    return arr;
}

/// 在滚动collectionview是否允许刷新布局
/// @param newBounds <#newBounds description#>
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

/// 确定最终偏移量
/// 什么时候调用：用户手指一松开
/// @param proposedContentOffset <#proposedContentOffset description#>
/// @param velocity <#velocity description#>
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //拖动比较快时：最终偏移量 ！=手指偏移量
    //拖动比较慢时，相等
    //最终偏移量
    CGPoint point =  [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    //手指偏移量
    CGPoint handle = self.collectionView.contentOffset;
    NSLog(@"最终偏移量%@",NSStringFromCGPoint(point));
    NSLog(@"手指偏移量%@",NSStringFromCGPoint(handle));
    return point;
}

@end
