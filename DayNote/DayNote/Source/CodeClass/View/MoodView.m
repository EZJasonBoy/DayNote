//
//  MoodView.m
//  DayNote
//
//  Created by youyou on 15/10/16.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import "MoodView.h"

@implementation MoodView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self p_setupView];
    }
    return self;
}
-(void)p_setupView
{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_scrollView];
    
    self.waveTableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.scrollView addSubview:_waveTableView];
    
//    self.graphView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waveTableView.frame), CGRectGetMinY(self.waveTableView.frame), CGRectGetWidth(self.waveTableView.frame), CGRectGetHeight(self.waveTableView.frame))];
//    self.graphView.backgroundColor = [UIColor redColor];
//    [self.scrollView addSubview:_graphView];
    
    
    
   
    
}

@end
