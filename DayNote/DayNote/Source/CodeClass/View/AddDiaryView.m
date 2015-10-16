//
//  AddDiaryView.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AddDiaryView.h"

@implementation AddDiaryView

- (UILabel *)datelabel {
    if (!_datelabel) {
        _datelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 90,32)];
        [self addSubview:_datelabel];
        _datelabel.backgroundColor = [UIColor flatPurpleColor];
    }
    return _datelabel;
}

- (UIButton *)moodSelect {
    if (!_moodSelect) {
        _moodSelect = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 50,32)];
        [self addSubview:_moodSelect];
        _moodSelect.backgroundColor = [UIColor flatPurpleColor];
    }
    return _moodSelect;
}

- (UIButton *)weatherShow {
    if (!_weatherShow) {
        _weatherShow = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 50,32)];
        _weatherShow.backgroundColor = [UIColor flatPurpleColor];
        [self addSubview:_weatherShow];
    }
    return _weatherShow;
}

@end
