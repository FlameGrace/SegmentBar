//
//  MoveSegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "MoveSegmentBar.h"

@implementation MoveSegmentBar
@synthesize selectItem = _selectItem;
@synthesize items = _items;
@synthesize selectIndex = _selectIndex;

- (void)didAddItem:(UIView *)item
{
    [self updateItemsFrame];
    [super didAddItem:item];
}

- (void)didRemoveItem:(UIView *)item
{
    [self updateItemsFrame];
    [super didRemoveItem:item];
}

- (void)didSelectedItem:(UIView *)item
{
    [self updateItemsFrame];
    [super didSelectedItem:item];
}


- (void)updateItemsFrame
{
    CGFloat width= self.frame.size.width;
    CGFloat height= self.frame.size.height;
    
    CGRect selectFrame = _selectItem.frame;
    if(selectFrame.size.height==0)
    {
        selectFrame.size.height = height;
    }
    _selectItem.frame = selectFrame;
    
    CGPoint selectCenter = _selectItem.center;
    selectCenter.x =  width/2;
    selectCenter.y =  height/2;
    _selectItem.center = selectCenter;
    
    NSInteger count = [_items count];
    for (NSInteger i = 0; i< _selectIndex; i++) {
        UIView *item = _items[i];
        CGFloat sumWidth = _selectItem.frame.size.width/2+_margin+item.frame.size.width/2;
        for (NSInteger j = i+1; j<_selectIndex; j++) {
            UIView *temp = _items[j];
            sumWidth += temp.frame.size.width+_margin;
        }
        CGRect frame = item.frame;
        if(frame.size.height==0)
        {
            frame.size.height = height;
        }
        item.frame = selectFrame;
        CGPoint center = item.center;
        center.x =  width/2 - sumWidth;
        center.y =  height/2;
        item.center = center;
    }
    for (NSInteger i = count-1; i>_selectIndex; i--) {
        UIView *item = _items[i];
        CGFloat sumWidth = _selectItem.frame.size.width/2+self.margin+item.frame.size.width/2;
        for (NSInteger j = i-1; j>self.selectIndex; j--) {
            UIView *temp = self.items[j];
            sumWidth += temp.frame.size.width+_margin;
        }
        CGRect frame = item.frame;
        if(frame.size.height==0)
        {
            frame.size.height = height;
        }
        item.frame = selectFrame;
        CGPoint center = item.center;
        center.x =  width/2 + sumWidth;
        center.y =  height/2;
        item.center = center;
    }
}


@end
