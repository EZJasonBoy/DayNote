//
//  MoodView.h
//  DayNote
//
//  Created by youyou on 15/10/16.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodView : UIView
@property(nonatomic,retain)UIScrollView *scrollView;

@property(nonatomic,retain)UITableView *waveTableView;
@property(nonatomic,retain)UIView *graphView;
@end
