//
//  CellItem.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/23.
//

#import "CellItem.h"

@implementation CellItem
//设计模型：空间需要展示什么内容，就定义什么属性
+ (instancetype)itemWithTitle:(NSString *)title
{
    CellItem *item = [[self alloc] init];
    item.title = title;
    return item;
}
@end
