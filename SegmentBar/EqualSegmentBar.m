//
//  EqualSegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "EqualSegmentBar.h"

@interface EqualSegmentBar()

@property (strong, nonatomic) UIView *baseLineView;
@property (strong, nonatomic) NSLayoutConstraint *baseLineViewCenterCon;
@property (strong, nonatomic) NSLayoutConstraint *baseLineViewWidthCon;

@end

@implementation EqualSegmentBar

-(void)setMargin:(CGFloat)margin
{
    _margin = margin;
    [self didUpdateUI];
}

-(void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    if(_contentHorizontalAlignment == contentHorizontalAlignment)
    {
        return;
    }
    _contentHorizontalAlignment = contentHorizontalAlignment;
    [self baseLineView];
    [self removeConstraint:self.baseLineViewCenterCon];
    if(contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        self.baseLineViewCenterCon = [NSLayoutConstraint constraintWithItem:self.baseLineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.contentEdgeInsets.left];
    }
    else if(contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight)
    {
        self.baseLineViewCenterCon = [NSLayoutConstraint constraintWithItem:self.baseLineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    }
    else
    {
        self.baseLineViewCenterCon = [NSLayoutConstraint constraintWithItem:self.baseLineView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-self.contentEdgeInsets.right];
    }
    [self addConstraint:self.baseLineViewCenterCon];
}

-(void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment
{
    if(_contentVerticalAlignment == contentVerticalAlignment)
    {
        return;
    }
    _contentVerticalAlignment = contentVerticalAlignment;
    [self didUpdateUI];
}

-(void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    _contentEdgeInsets = contentEdgeInsets;
    [self didUpdateUI];
}

- (void)didUpdateUI
{
    @synchronized(self)
    {
        [self updateItemsFrame];
        [super didUpdateUI];
    }
}

- (void)updateItemsFrame
{
    NSArray *items = [NSArray arrayWithArray:self.items];
    NSInteger count = [items count];
    CGFloat currentX = 0;
    
    for (NSInteger i = 0; i< count; i++) {
        UIView *item = items[i];
        [item sizeToFit];
        item.translatesAutoresizingMaskIntoConstraints = NO;
        CGFloat itemWidth = item.frame.size.width;
        CGFloat itemHeight = item.frame.size.height;
        
        NSArray *constraints = [NSArray arrayWithArray:self.constraints];
        for (NSLayoutConstraint *con in constraints) {
            if([con.firstItem isEqual:item])
            {
                [self removeConstraint:con];
            }
        }
        
        if(_contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseLineView attribute:NSLayoutAttributeTop multiplier:1.0 constant:_contentEdgeInsets.top]];
        }
        else if(_contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseLineView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:- _contentEdgeInsets.bottom]];
        }
        else
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.baseLineView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        }
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseLineView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:currentX]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:itemHeight]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:itemWidth]];
        currentX += itemWidth + _margin;
    }
    
    self.baseLineViewWidthCon.constant = currentX - _margin;
}

- (CGSize)contentSize
{
    return self.baseLineView.frame.size;
}


- (UIView *)baseLineView
{
    if(!_baseLineView)
    {
        _baseLineView = [[UIView alloc]init];
        _baseLineView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_baseLineView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_baseLineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_baseLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        self.baseLineViewWidthCon = [NSLayoutConstraint constraintWithItem:_baseLineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0];
        [self addConstraint:self.baseLineViewWidthCon];
        
        self.baseLineViewCenterCon = [NSLayoutConstraint constraintWithItem:_baseLineView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        [self addConstraint:self.baseLineViewCenterCon];
        
        [self sendSubviewToBack:_baseLineView];
    }
    return _baseLineView;
}


@end
