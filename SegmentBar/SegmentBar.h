//
//  SegmentBar.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// 虚基类，只包含该有的逻辑，不包含UI

#import <UIKit/UIKit.h>
#import "SegmentBarProtocol.h"



@interface SegmentBar : UIView <SegmentBarProtocol>

@property(nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;


@end
