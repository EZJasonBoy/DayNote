//
//  CalendarView.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView

- (UIView *)calendarView
{
    if (_calendarView == nil) {
        _calendarView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, CGRectGetWidth([[UIScreen mainScreen]bounds]), 300)];
        // _calendarView.backgroundColor = [UIColor purpleColor];
        [self addSubview:_calendarView];
    }
    return _calendarView;
}

- (UITableView *)noteTable
{
    if (_noteTable == nil) {
        _noteTable = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.calendarView.frame), CGRectGetMaxY(self.calendarView.frame), CGRectGetWidth(self.calendarView.frame), CGRectGetHeight([[UIScreen mainScreen]bounds]) - CGRectGetHeight(self.calendarView.frame)) style:UITableViewStyleGrouped];
        _noteTable.backgroundColor = [UIColor grayColor];
        [self addSubview:_noteTable];
    }
    return _noteTable;
}


@end
