//
//  SegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "SegmentBar.h"

@interface SegmentBar()

@property (readwrite, strong, nonatomic) NSMutableArray *items;
@property (readwrite, strong, nonatomic) UIView *selectItem;
@property (readwrite, strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@end

@implementation SegmentBar
@synthesize delegate = _delegate;
@synthesize selectIndex = _selectIndex;
@synthesize items = _items;
@synthesize selectItem = _selectItem;


- (instancetype)init
{
    if(self = [super init])
    {
        [self initValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initValues];
    }
    return self;
}

- (void)initValues
{
    if(!self.items)
    {
        self.items = [[NSMutableArray alloc]init];
    }
    if(!self.tapGestureRecognizer)
    {
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSelect:)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
}


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

- (void)didDeSelectedIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didDeSelectedIndex:)])
    {
        [self.delegate segmentBar:self didDeSelectedIndex:index];
    }
}

- (void)didUpdateUI
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBarDidUpdateUI:)])
    {
        [self.delegate segmentBarDidUpdateUI:self];
    }
}

- (BOOL)shouldSelectIndex:(NSInteger)index
{
    BOOL should = YES;
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:shouldSelectIndex:)])
    {
        should = [self.delegate segmentBar:self shouldSelectIndex:index];
    }
    
    return should;
}

- (void)didSelectedIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didSelectedIndex:)])
    {
        [self.delegate segmentBar:self didSelectedIndex:index];
    }
}

- (void)selectIndexDidChangedFrom:(NSInteger)oldIndex to:(NSInteger)newIndex
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(userSelectChangedFrom:to:)])
    {
        [self.delegate userSelectChangedFrom:oldIndex to:newIndex];
    }
}


- (void)addItem:(UIView *)item
{
    if(!item)
    {
        return;
    }
    if(item && ![item isKindOfClass:[UIView class]])
    {
        return;
    }
    item.userInteractionEnabled = NO;
    [self.items addObject:item];
    [self addSubview:item];
    [self didAddItem:item];
    [self didUpdateUI];
    if(self.items.count == 1)
    {
        [self selectItemByIndex:0];
    }
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
        [self didUpdateUI];
        if(self.selectItem && [self.selectItem isEqual:item])
        {
            self.selectItem = nil;
            [self selectItemByIndex:0];
        }
        if(self.items.count == 1)
        {
            [self selectItemByIndex:0];
        }
    }
}

- (void)addItems:(NSArray *)items
{
    for (UIView *item in items) {
        [self addItem:item];
    }
}

- (void)removeItems:(NSArray *)items
{
    for (UIView *item in items) {
        [self removeItem:item];
    }
}

- (void)handleSelect:(UIGestureRecognizer *)tap
{
    if(tap.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [tap locationInView:self];
        NSArray *items = [[NSArray alloc]initWithArray:self.items];
        __block UIView *selectItem = nil;
        [items enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = [self convertRect:obj.frame fromView:obj.superview];
            if(CGRectContainsPoint(frame,location))
            {
                selectItem = obj;
                *stop = YES;
            }
        }];
        
        if(selectItem && [self.items containsObject:selectItem])
        {
            self.selectIndex = [self.items indexOfObject:selectItem];
        }
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if(_selectIndex == selectIndex)
    {
        return;
    }
    [self selectItemByIndex:selectIndex];
}

- (void)selectItemByIndex:(NSInteger)index
{
    if(index >= [self.items count] || index < 0)
    {
        return;
    }
    UIView *selectItem = [self.items objectAtIndex:index];
    if(selectItem)
    {
        NSInteger old = _selectIndex;
        if([self shouldSelectIndex:index])
        {
            if(_selectItem)
            {
                [self didDeSelectedIndex:_selectIndex];
                [self didUpdateUI];
            }
            
            _selectItem = selectItem;
            _selectIndex = index;
            [self didSelectedIndex:index];
            [self didUpdateUI];
        }
        [self selectIndexDidChangedFrom:old to:index];
    }
    else
    {
        _selectIndex = 0;
        _selectItem = nil;
    }
}


@end
