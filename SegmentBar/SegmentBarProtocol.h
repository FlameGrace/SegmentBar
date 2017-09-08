//
//  SegmentBarProtocol.h
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SegmentBarProtocol <NSObject>

- (BOOL)shouldSelectItem:(UIView *)item;

- (void)didSelectedItem:(UIView *)item;

- (void)didDeSelectedItem:(UIView *)item;

- (void)didRemoveItem:(UIView *)item;

- (void)didAddItem:(UIView *)item;



@end
