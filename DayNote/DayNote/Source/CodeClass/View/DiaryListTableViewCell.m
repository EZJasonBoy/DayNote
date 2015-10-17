//
//  DiaryListTableViewCell.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DiaryListTableViewCell.h"

@implementation DiaryListTableViewCell

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(8, 0, 360, 134)];
        [self.contentView addSubview:_backView];
    }
    return _backView;
}

- (UILabel *)weatherLabel {
    if (!_weatherLabel) {
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 4, 40, 33)];
        [self addSubview:_weatherLabel];
    }
    return _weatherLabel;
}

- (UIImageView *)weatherImageView {
    if (!_weatherImageView) {
        _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.weatherLabel.frame)+10, 2, 42, 37)];
        [self addSubview:_weatherImageView];
    }
    return _weatherImageView;
}

- (UILabel *)moodLabel {
    if (!_moodLabel) {
        _moodLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.weatherImageView.frame)+20, 4, 40, 33)];
        [self addSubview:_moodLabel];
    }
    return _moodLabel;
}
- (UIImageView *)moodImageView {
    if (!_moodImageView) {
        _moodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moodLabel.frame)+10, 2, 42, 37)];
        [self addSubview:_moodImageView];
    }
    return _moodImageView;
}
- (UILabel *)detailsText {
    if (!_detailsText) {
        _detailsText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.weatherLabel.frame), CGRectGetMaxY(self.weatherImageView.frame)+2, 339, 32)];
        _detailsText.numberOfLines = 0;
        _detailsText.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_detailsText];
    }
    return _detailsText;
}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
