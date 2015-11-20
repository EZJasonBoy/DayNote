//
//  ShareTableViewCell.m
//  DayNote
//
//  Created by boluchuling on 15/10/26.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "ShareTableViewCell.h"

@implementation ShareTableViewCell

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.contentView.frame)+5, CGRectGetMinY(self.contentView.frame)+5, CGRectGetWidth(self.contentView.frame)-10, CGRectGetHeight(self.contentView.frame)-10)];
        _backView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%254/255.0];
        _backView.layer.cornerRadius = 5;
        
        [self.contentView addSubview:_backView];
    }
    return _backView;
}

- (UILabel *)createDate {
    if (_createDate == nil) {
        _createDate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backView.frame)+5, CGRectGetMinY(self.backView.frame)+5, 100, 30)];
        [self.backView addSubview:_createDate];
    }
    return _createDate;
}

- (UILabel *)weather {
    if (_weather == nil) {
        _weather = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.createDate.frame)+5, CGRectGetMinY(self.createDate.frame), CGRectGetWidth(self.createDate.frame)-50, CGRectGetHeight(self.createDate.frame))];
        [self.backView addSubview:_weather];
    }
    return _weather;
}
- (UILabel *)mood {
    if (_mood == nil) {
        _mood = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.weather.frame)+5, CGRectGetMinY(self.weather.frame), CGRectGetWidth(self.weather.frame), CGRectGetHeight(self.weather.frame))];
        [self.backView addSubview:_mood];
    }
    return _mood;
}
- (UILabel *)diaryBody {
    if (_diaryBody == nil) {
        _diaryBody = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.createDate.frame), CGRectGetMaxY(self.createDate.frame), CGRectGetWidth(self.backView.frame)-10, 60)];
        _diaryBody.numberOfLines = 2;
        [self.backView addSubview:_diaryBody];
    }
    return _diaryBody;
}

- (UILabel *)placetext {
    if (_placetext == nil) {
        _placetext = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.diaryBody.frame)-150, CGRectGetMaxY(self.diaryBody.frame), 60, 30)];
        _placetext.text = @"来源地:";
        [self.backView addSubview:_placetext];
    }
    return _placetext;
}

- (UILabel *)city {
    if (_city == nil) {
        _city = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.placetext.frame), CGRectGetMinY(self.placetext.frame), 100, 30)];
        [self.backView addSubview:_city];
    }
    return _city;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
