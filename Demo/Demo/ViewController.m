//
//  ViewController.m
//  Demo
//
//  Created by Flame Grace on 2017/9/7.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "ViewController.h"
#import "EqualSegmentBar.h"
#import "MoveSegmentBar.h"

@interface ViewController () <SegmentBarDelegate>

@property (strong, nonatomic) EqualSegmentBar *equal;
@property (strong, nonatomic) MoveSegmentBar *move;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.move = [[MoveSegmentBar alloc]initWithFrame:CGRectMake(0, 100, 300, 44)];
    self.move.backgroundColor = [UIColor lightGrayColor];
    self.move.margin = 80;
    [self.view addSubview:self.move];
    self.move.delegate = self;
    UILabel *l1 = [self label:@"我的"];
    [self.move addItem:l1];
    UILabel *l2 = [self label:@"你的"];
    [self.move addItem:l2];
    UILabel *l3 = [self label:@"他的"];
    [self.move addItem:l3];
    UILabel *l4 = [self label:@"她的"];
    [self.move addItem:l4];
    UILabel *l5 = [self label:@"它的"];
    [self.move addItem:l5];
    UILabel *l6 = [self label:@"ta的"];
    [self.move addItem:l6];
    self.move.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.move attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.move attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.move attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.move attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:355]];
    
    
    
    self.equal = [[EqualSegmentBar alloc]initWithFrame:CGRectMake(10, 200, 355, 80)];
    self.equal.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.equal];
    self.equal.delegate = self;
    self.equal.margin = 40;
    self.equal.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    UIButton *e1 = [self button:@"我的"];
    [self.equal addItem:e1];
    UIButton *e2 = [self button:@"你的"];
    [self.equal addItem:e2];
//    UIButton *e3 = [self button:@"他的"];
//    [self.equal addItem:e3];
//    UIButton *e4 = [self button:@"d的"];
//    [self.equal addItem:e4];
//    UIButton *e5 = [self button:@"dfdf的"];
//    [self.equal addItem:e5];
    
    
//        self.equal.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.equal attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
//
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.equal attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200.0]];
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.equal attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
//
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.equal attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:355]];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view updateConstraints];
    [self.equal updateConstraints];
}

- (void)segmentBar:(SegmentBar *)segmentBar didSelectedItem:(UILabel *)item
{
    if([item isKindOfClass:[UIButton class]])
    {
//        self.equal.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.equal.margin = 200;
        [(UIButton *)item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        return;
    }
    item.textColor = [UIColor redColor];
    item.font = [UIFont systemFontOfSize:22];
}

- (void)segmentBar:(SegmentBar *)segmentBar didDeSelectedItem:(UILabel *)item
{
    if([item isKindOfClass:[UIButton class]])
    {
        [(UIButton *)item setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        return;
    }
    item.textColor = [UIColor blueColor];
    item.font = [UIFont systemFontOfSize:17];
}

- (BOOL)segmentBar:(SegmentBar *)segmentBar shouldSelectItem:(UILabel *)item
{
    BOOL should = YES;
    if([segmentBar isEqual:self.equal])
    {
        if([segmentBar.items indexOfObject:item] == 2)
        {
            should = NO;
        }
    }
    
    return should;
}

- (UILabel *)label:(NSString *)title
{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    return label;
}

- (UIButton *)button:(NSString *)title
{
    UIButton *label = [[UIButton alloc]init];
    [label setTitle:title forState:UIControlStateNormal];
    [label setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    label.backgroundColor = [UIColor blackColor];
    return label;
}


@end
