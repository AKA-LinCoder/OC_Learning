//
//  VCView.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "VCView.h"

@implementation VCView
//返回当前UIView内部layer类型
+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

@end
