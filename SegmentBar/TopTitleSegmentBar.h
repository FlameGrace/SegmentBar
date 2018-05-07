//
//  TopTitleSegmentBar.h
//  AFNetworking
//
//  Created by MAC on 2018/5/4.
//  Flame Grace： 根据传入的NSString数组，自动生成label，可以设置未选中和被选中label的样式，被选中的label下面有下划线
//  可在我的车辆、通知、控制页查看样式

#import "EqualSegmentBar.h"

@interface TopTitleSegmentBar : EqualSegmentBar

@property (strong, nonatomic) UIFont *defaultTextFont;
@property (strong, nonatomic) UIFont *selectTextFont;
@property (strong, nonatomic) UIColor *defaultTextColor;
@property (strong, nonatomic) UIColor *selectTextColor;
@property (strong, nonatomic) UIColor *textBackgroundColor;

- (instancetype)initWithTitles:(NSArray *)titles;

- (void)addTitles:(NSArray *)titles;

@end
