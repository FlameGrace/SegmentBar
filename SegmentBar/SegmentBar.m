//
//  SegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "SegmentBar.h"

@interface SegmentBar()

@property (readwrite, strong, nonatomic) NSMutableArray *items;
@property (readwrite, strong, nonatomic) UIView * selectItem;
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation SegmentBar

-(void)didAddItem:(UIView *)item
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didAddItem:)])
    {
        [self.delegate segmentBar:self didAddItem:item];
    }
}

- (void)didRemoveItem:(UIView *)item
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didRemoveItem:)])
    {
        [self.delegate segmentBar:self didRemoveItem:item];
    }
}

- (BOOL)shouldSelectItem:(UIView *)item
{
    BOOL should = YES;
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:shouldSelectItem:)])
    {
        should = [self.delegate segmentBar:self shouldSelectItem:item];
    }
    return should;
}

- (void)didSelectedItem:(UIView *)item
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didSelectedItem:)])
    {
        [self.delegate segmentBar:self didSelectedItem:item];
    }
}


- (void)addItem:(UIView *)item
{
    if(!item)
    {
        return;
    }
    [self.items addObject:item];
    [self addSubview:item];
    [self didAddItem:item];
}

- (void)removeItem:(UIView *)item
{
    if(!item)
    {
        return;
    }
    if([self.items containsObject:item])
    {
        [self.items removeObject:item];
        [item removeFromSuperview];
        [self didRemoveItem:item];
        if(self.selectItem && [self.selectItem isEqual:item])
        {
            self.selectItem = nil;
            self.selectIndex = 0;
        }
    }
}

- (void)handleSelect:(UIGestureRecognizer *)tap
{
    if(tap.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [tap locationInView:self];
        NSArray *items = [[NSArray alloc]initWithArray:self.items];
        __block UIView *selectItem = nil;
        [items enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(CGRectContainsPoint(obj.frame,location))
            {
                selectItem = obj;
                *stop = YES;
            }
        }];
        
        if(selectItem && [self.items containsObject:selectItem])
        {
            self.selectIndex = [self.items indexOfObject:selectItem];
        }
        
        if(selectItem&&[self shouldSelectItem:selectItem]&&[self.items containsObject:selectItem])
        {
            self.selectIndex = [self.items indexOfObject:selectItem];
            [self didSelectedItem:selectItem];
        }
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if(selectIndex >= [self.items count] || selectIndex < 0)
    {
        return;
    }
    if(_selectIndex == selectIndex)
    {
        return;
    }
    UIView *selectItem = [self.items objectAtIndex:selectIndex];
    if(selectItem)
    {
        if([self shouldSelectItem:selectItem])
        {
            _selectItem = selectItem;
            _selectIndex = selectIndex;
            [self didSelectedItem:selectItem];
        }
    }
    else
    {
        _selectIndex = 0;
        _selectItem = nil;
    }
}


- (NSMutableArray *)items
{
    if(!_items)
    {
        _items = [[NSMutableArray alloc]init];
    }
    return _items;
}

- (UITapGestureRecognizer *)tap
{
    if(!_tap)
    {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSelect:)];
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}

@end
