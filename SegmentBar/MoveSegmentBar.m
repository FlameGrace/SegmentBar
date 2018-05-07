//
//  MoveSegmentBar.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "MoveSegmentBar.h"

@implementation MoveSegmentBar

-(void)setMargin:(CGFloat)margin
{
    _margin = margin;
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
    self.clipsToBounds = YES;
    CGFloat width= self.frame.size.width;
    CGFloat height= self.frame.size.height;
    CGRect selectFrame = self.selectItem.frame;
    if(selectFrame.size.height==0)
    {
        selectFrame.size.height = height;
    }
    self.selectItem.frame = selectFrame;
    [self.selectItem sizeToFit];
    
    CGPoint selectCenter = self.selectItem.center;
    selectCenter.x =  width/2;
    selectCenter.y =  height/2;
    self.selectItem.center = selectCenter;
    
    NSInteger count = [self.items count];
    for (NSInteger i = 0; i< self.selectIndex; i++) {
        UIView *item = self.items[i];
        [item sizeToFit];
        CGFloat sumWidth = self.selectItem.frame.size.width/2+_margin+item.frame.size.width/2;
        for (NSInteger j = i+1; j<self.selectIndex; j++) {
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
        center.x =  width/2 - sumWidth;
        center.y =  height/2;
        item.center = center;
    }
    for (NSInteger i = count-1; i>self.selectIndex; i--) {
        UIView *item = self.items[i];
        [item sizeToFit];
        CGFloat sumWidth = self.selectItem.frame.size.width/2+_margin+item.frame.size.width/2;
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
