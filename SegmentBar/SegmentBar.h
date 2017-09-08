//
//  SegmentBar.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBarDelegate.h"
#import "SegmentBarProtocol.h"



@interface SegmentBar : UIView <SegmentBarProtocol>

@property (weak,nonatomic) id <SegmentBarDelegate> delegate;

@property (readonly, nonatomic) NSMutableArray *items;

@property (readonly, nonatomic) UIView *selectItem;

@property (nonatomic, assign) NSInteger selectIndex;

- (void)addItem:(UIView*)item;

- (void)removeItem:(UIView*)item;

@end
