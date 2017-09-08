//
//  SegmentBarDelegate.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//


#import <Foundation/Foundation.h>

@class SegmentBar;

@protocol SegmentBarDelegate <NSObject>

/**
 *  当SegmentBar被切换时触发此代理方法
 *
 */
- (void)segmentBar:(SegmentBar *)segmentBar didSelectedItem:(UIView*)item;

- (void)segmentBar:(SegmentBar *)segmentBar didRemoveItem:(UIView*)item;

- (void)segmentBar:(SegmentBar *)segmentBar didAddItem:(UIView*)item;

@optional
/**
 *  当SegmentBar将要切换时触发此代理方法，返回成功则切换，返回NO则不切换
 *
 */
- (BOOL)segmentBar:(SegmentBar *)segmentBar shouldSelectItem:(UIView*)item;

@end
