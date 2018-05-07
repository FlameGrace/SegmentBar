//
//  TopTitleSegmentBar.m
//  AFNetworking
//
//  Created by MAC on 2018/5/4.
//

#import "TopTitleSegmentBar.h"

@interface TopTitleSegmentBar()

@property (strong, nonatomic) UIView *selectBottomView;
@property (strong, nonatomic) NSLayoutConstraint *selectBottomViewCenterCon;

@end

@implementation TopTitleSegmentBar

- (instancetype)init
{
    if(self = [super init])
    {
        [self initDefaultValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initDefaultValue];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles
{
    if(self = [super init])
    {
        [self initDefaultValue];
        [self addTitles:titles];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateSelectBottomView];
}

- (void)initDefaultValue
{
    self.margin = 40;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.defaultTextFont = [UIFont systemFontOfSize:16];
    self.selectTextFont = [UIFont systemFontOfSize:16];
    self.defaultTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    self.selectTextColor = [UIColor whiteColor];
    self.textBackgroundColor = [UIColor clearColor];
    if(!self.selectBottomView)
    {
        self.selectBottomView = [[UIView alloc]init];
        self.selectBottomView.backgroundColor = self.selectTextColor;
        self.selectBottomView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.selectBottomView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.selectBottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];

        self.selectBottomViewCenterCon = [NSLayoutConstraint constraintWithItem:self.selectBottomView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:self.selectBottomViewCenterCon];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.selectBottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.selectBottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:2.0]];
    }
}


- (void)addTitles:(NSArray *)titles
{
    NSArray *items = [self itemsByTitles:titles];
    [self addItems:items];
}

- (NSArray *)itemsByTitles:(NSArray *)titles
{
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *title in titles) {
        if(![title isKindOfClass:[NSString class]])
        {
            continue;
        }
        if(title.length < 1)
        {
            continue;
        }
        UILabel *label = [[UILabel alloc]init];
        label.font = _defaultTextFont;
        label.textColor = _defaultTextColor;
        label.text = title;
        label.backgroundColor = self.textBackgroundColor;
        [items addObject:label];
    }
    return items;
}

- (void)didSelectedIndex:(NSInteger)index
{
    [super didSelectedIndex:index];
    [self updateSelectUI];
    [self updateSelectBottomView];
}

- (void)didDeSelectedIndex:(NSInteger)index
{
    [super didSelectedIndex:index];
    [self updateSelectUI];
}

- (void)updateSelectUI
{
    NSArray *items = [NSArray arrayWithArray:self.items];
    for (UILabel *label in items) {
        label.backgroundColor = self.textBackgroundColor;
        if(label&&[label isKindOfClass:[UILabel class]])
        {
            if([label isEqual:self.selectItem])
            {
                label.font = self.selectTextFont;
                label.textColor = self.selectTextColor;
            }
            else
            {
                label.font = self.defaultTextFont;
                label.textColor = self.defaultTextColor;
            }
        }
    }
}

- (void)updateSelectBottomView
{
    //若self未被addSubview，则会导致崩溃，必须在layoutSubviews中重新调用该方法
    if(self.selectBottomView && self.superview && self.selectItem)
    {
        if(self.selectIndex<self.items.count)
        {
            [self removeConstraint:self.selectBottomViewCenterCon];
            self.selectBottomViewCenterCon = [NSLayoutConstraint constraintWithItem:self.selectBottomView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.selectItem attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
            [self addConstraint:self.selectBottomViewCenterCon];
            [self bringSubviewToFront:self.selectBottomView];
        }
    }
}


- (void)setSelectTextFont:(UIFont *)selectTextFont
{
    _selectTextFont = selectTextFont;
    [self didUpdateUI];
}

- (void)setSelectTextColor:(UIColor *)selectTextColor
{
    _selectTextColor = selectTextColor;
    [self updateSelectUI];
}

- (void)setDefaultTextFont:(UIFont *)defaultTextFont
{
    _defaultTextFont = defaultTextFont;
    [self updateSelectUI];
}

- (void)setDefaultTextColor:(UIColor *)defaultTextColor
{
    _defaultTextColor = defaultTextColor;
    [self updateSelectUI];
}

- (void)setTextBackgroundColor:(UIColor *)textBackgroundColor
{
    _textBackgroundColor = textBackgroundColor;
    [self updateSelectUI];
}

@end
