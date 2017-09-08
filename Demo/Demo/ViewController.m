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
    self.move = [[MoveSegmentBar alloc]initWithFrame:CGRectMake(0, 100, 200, 44)];
    self.move.backgroundColor = [UIColor lightGrayColor];
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
    self.move.margin = 20;
//    self.move.scrollEnabled = YES;
//    self.move.showsHorizontalScrollIndicator = NO;
//    self.move.contentSize =  CGSizeMake(500, 0);
    
    
    
    self.equal = [[EqualSegmentBar alloc]initWithFrame:CGRectMake(0, 300, 200, 44)];
    self.equal.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.equal];
    self.equal.delegate = self;
    UIButton *e1 = [self button:@"我的"];
    [self.equal addItem:e1];
    UIButton *e2 = [self button:@"你的"];
    [self.equal addItem:e2];
    UIButton *e3 = [self button:@"他的"];
    [self.equal addItem:e3];
    self.equal.margin = 40;
    
    
    
}


- (void)segmentBar:(SegmentBar *)segmentBar didSelectedItem:(UILabel *)item
{
    if([item isKindOfClass:[UIButton class]])
    {
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

//- (BOOL)segmentBar:(SegmentBar *)segmentBar shouldSelectItem:(UILabel *)item
//{
//    BOOL should = YES;
//    if([segmentBar isEqual:self.equal])
//    {
//        if([segmentBar.items indexOfObject:item] == 2)
//        {
//            should = NO;
//        }
//    }
//    
//    return should;
//}

- (UILabel *)label:(NSString *)title
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 50, 30)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    return label;
}

- (UIButton *)button:(NSString *)title
{
    UIButton *label = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 50, 30)];
    [label setTitle:title forState:UIControlStateNormal];
    [label setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    return label;
}


@end
