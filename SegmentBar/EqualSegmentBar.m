//
//  EqualSegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "EqualSegmentBar.h"

@interface EqualSegmentBar()

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSLayoutConstraint *contentViewCenterCon;
@property (strong, nonatomic) NSLayoutConstraint *contentViewWidthCon;

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
    [self removeConstraint:self.contentViewCenterCon];
    if(contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        self.contentViewCenterCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    }
    else if(contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight)
    {
        self.contentViewCenterCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    }
    else
    {
        self.contentViewCenterCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    }
    [self addConstraint:self.contentViewCenterCon];
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
        [item removeFromSuperview];
        [self.contentView addSubview:item];
        
        if(_contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
        {
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:item.frame.origin.y]];
        }
        else if(_contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
        {
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-item.frame.origin.y]];
        }
        else
        {
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        }
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:currentX]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:itemHeight]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:itemWidth]];
        currentX += itemWidth + _margin;
    }
    
    self.contentViewWidthCon.constant = currentX - _margin;
}

- (CGSize)contentSize
{
    return self.contentView.frame.size;
}


- (UIView *)contentView
{
    if(!_contentView)
    {
        _contentView = [[UIView alloc]init];
        _contentView.translatesAutoresizingMaskIntoConstraints = nil;
        [self addSubview:_contentView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        self.contentViewCenterCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        [self addConstraint:self.contentViewCenterCon];
        
        self.contentViewWidthCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0];
        [self addConstraint:self.contentViewWidthCon];
    }
    return _contentView;
}


@end
