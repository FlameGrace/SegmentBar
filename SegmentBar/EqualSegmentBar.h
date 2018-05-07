//
//  EqualSegmentBar.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// Flame Grace： 普通SegmentBar，各item根据margin相隔排列

#import "SegmentBar.h"

@interface EqualSegmentBar : SegmentBar

@property (nonatomic, assign) CGFloat margin; //item的间距

@property(nonatomic,assign) UIEdgeInsets contentEdgeInsets; //content与左右上下之间的间距
@property(nonatomic,assign) UIControlContentHorizontalAlignment contentHorizontalAlignment; //水平对齐
@property(nonatomic,assign) UIControlContentVerticalAlignment contentVerticalAlignment; //垂直对齐

@end
