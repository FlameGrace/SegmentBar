//
//  EqualSegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "EqualSegmentBar.h"

@implementation EqualSegmentBar

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

-(void)setMargin:(CGFloat)margin
{
    _margin = margin;
    [self updateItemsFrame];
}

- (void)updateItemsFrame
{
    CGFloat width= self.frame.size.width;
    CGFloat height= self.frame.size.height;
    NSInteger count = [self.items count];
    CGFloat itemWidth = (width-(count-1)*_margin)/count;
    
    for (int i = 0; i< count; i++) {
        UIView *item = self.items[i];
        CGFloat x = i*(itemWidth + _margin);
        CGRect frame = item.frame;
        frame.origin.x = x;
        frame.size.width = itemWidth;
        if(frame.size.height==0)
        {
            frame.size.height = height;
        }
        item.frame = frame;
        CGPoint center = item.center;
        center.y =  height/2;
        item.center = center;
    }
}



@end
