//
//  DiaryDetailsView.m
//  DayNote
//
//  Created by boluchuling on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DiaryDetailsView.h"

@implementation DiaryDetailsView

- (UIScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self addSubview:_backScrollView];
    }
    return _backScrollView;
}

- (UIImageView *)weatherImage {
    if (!_weatherImage) {
        _weatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame)+80, CGRectGetMinY(self.window.frame)+10, 42, 37)];
        [self.backScrollView addSubview:_weatherImage];
    }
    return _weatherImage;
}
    
- (UIImageView *)moodImage {
    if (!_moodImage) {
        _moodImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.weatherImage.frame)+120, CGRectGetMinY(self.window.frame)+10, 42, 37)];
        
        [self.backScrollView addSubview:_moodImage];
    }
    return _moodImage;
}
    
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.weatherImage.frame)+10, CGRectGetWidth(self.frame)-5, 100)];
        _textLabel.numberOfLines = 0;
        [self.backScrollView addSubview:_textLabel];
    }
    return _textLabel;
}

- (UIImageView *)myImage {
    if (!_myImage) {
        if ([self.textLabel.text isEqualToString:@""]) {
            _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 45, 100, 100)];
        }else {
            _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textLabel.frame), CGRectGetMaxY(self.textLabel.frame)+10, 100, 100)];
        }
        [self.backScrollView addSubview:_myImage];
    }
    return _myImage;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(305, 531, 40, 40)];
       
        _editButton.layer.cornerRadius = 20;
        _editButton.clipsToBounds = YES;
        [_editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        
        [_editButton addTarget:self action:@selector(writeDiary:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_editButton];
        [self bringSubviewToFront:_editButton];
    }
    return _editButton;
}

- (void)writeDiary:(UIButton *)sender {
    [self.delegate writeDiary];
}
@end
