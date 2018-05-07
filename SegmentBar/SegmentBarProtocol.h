//
//  SegmentBarProtocol.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SegmentBarProtocol;

@protocol SegmentBarDelegate <UIScrollViewDelegate>

@optional

- (void)userSelectChangedFrom:(NSInteger)oldIndex to:(NSInteger)newIndex;

/**
 *  当SegmentBar被切换时触发此代理方法
 *
 */
- (void)segmentBar:(id <SegmentBarProtocol>)segmentBar didSelectedIndex:(NSInteger)index;

- (void)segmentBar:(id <SegmentBarProtocol>)segmentBar didDeSelectedIndex:(NSInteger)index;

- (void)segmentBar:(id <SegmentBarProtocol>)segmentBar didRemoveItem:(UIView*)item;

- (void)segmentBar:(id <SegmentBarProtocol>)segmentBar didAddItem:(UIView*)item;

/**
 *  当SegmentBar将要切换时触发此代理方法，返回成功则切换，返回NO则不切换
 *
 */
- (BOOL)segmentBar:(id <SegmentBarProtocol>)segmentBar shouldSelectIndex:(NSInteger)index;

- (BOOL)segmentBarDidUpdateUI:(id <SegmentBarProtocol>)segmentBar;

@end


@protocol SegmentBarProtocol <NSObject>

@property (weak,nonatomic) id <SegmentBarDelegate> delegate;

@property (readonly, nonatomic) NSMutableArray *items;

@property (readonly, nonatomic) UIView *selectItem;

@property (nonatomic, assign) NSInteger selectIndex;

- (void)addItem:(UIView *)item;

- (void)removeItem:(UIView *)item;

- (void)addItems:(NSArray *)items;

- (void)removeItems:(NSArray *)items;

- (BOOL)shouldSelectIndex:(NSInteger)index;

- (void)didSelectedIndex:(NSInteger)index;

- (void)didDeSelectedIndex:(NSInteger)index;

- (void)didRemoveItem:(UIView *)item;

- (void)didAddItem:(UIView *)item;

- (void)didUpdateUI;

- (void)selectIndexDidChangedFrom:(NSInteger)oldIndex to:(NSInteger)newIndex;



@end
