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
@property (readwrite, strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@end

@implementation SegmentBar
@synthesize delegate = _delegate;


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

- (void)didDeSelectedItem:(UIView *)item
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didDeSelectedItem:)])
    {
        [self.delegate segmentBar:self didDeSelectedItem:item];
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
    item.userInteractionEnabled = NO;
    [self.items addObject:item];
    [self addSubview:item];
    [self didAddItem:item];
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

- (void)handleSelect:(UIGestureRecognizer *)tap
{
    if(tap.state == UIGestureRecognizerStateEnded)
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
    [self selectItemByIndex:selectIndex];
}

- (void)selectItemByIndex:(NSInteger)index
{
    UIView *selectItem = [self.items objectAtIndex:index];
    if(selectItem)
    {
        if([self shouldSelectItem:selectItem])
        {
            
            if(_selectItem)
            {
                UIView *item = _selectItem;
                [self didDeSelectedItem:item];
            }
            
            _selectItem = selectItem;
            _selectIndex = index;
            [self didSelectedItem:selectItem];
        }
    }
    else
    {
        _selectIndex = 0;
        _selectItem = nil;
    }
}


@end
