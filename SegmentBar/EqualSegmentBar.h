//
//  EqualSegmentBar.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "SegmentBar.h"

@interface EqualSegmentBar : SegmentBar

@property (nonatomic, assign) CGFloat margin;

@property(nonatomic,assign) UIControlContentHorizontalAlignment contentHorizontalAlignment;
@property(nonatomic,assign) UIControlContentVerticalAlignment contentVerticalAlignment;

@property(readonly, nonatomic,assign) CGSize contentSize;

@end
