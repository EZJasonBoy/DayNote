//
//  DiaryDetailsView.m
//  DayNote
//
//  Created by lanou3g on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DiaryDetailsView.h"

@implementation DiaryDetailsView

- (UIImageView *)weatherImage {
    if (!_weatherImage) {
        _weatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame)+80, CGRectGetMinY(self.window.frame)+10, 50, 30)];
        [self addSubview:_weatherImage];
    }
    return _weatherImage;
}
    
- (UIImageView *)moodImage {
    if (!_moodImage) {
        _moodImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.weatherImage.frame)+120, CGRectGetMinY(self.window.frame)+10, 50, 30)];
        _moodImage.backgroundColor = [UIColor redColor];
        [self addSubview:_moodImage];
    }
    return _moodImage;
}
    
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, CGRectGetWidth(self.frame)-5, 100)];
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

- (UIImageView *)myImage {
    if (!_myImage) {
        if ([self.textLabel.text isEqualToString:@""]) {
            _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 45, 100, 100)];
        }else {
            _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textLabel.frame), CGRectGetMaxY(self.textLabel.frame)+10, CGRectGetWidth(self.textLabel.frame)/2, CGRectGetWidth(self.textLabel.frame)/2)];
        }
        [self addSubview:_myImage];
    }
    return _myImage;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(305, 531, 40, 40)];
       
        _editButton.layer.cornerRadius = 20;
        _editButton.clipsToBounds = YES;
        [_editButton setImage:[UIImage imageNamed:@"edit_23"] forState:UIControlStateNormal];
        
        [_editButton addTarget:self action:@selector(writeDiary:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_editButton];
    }
    return _editButton;
}

- (void)writeDiary:(UIButton *)sender {
    [self.delegate writeDiary];
}
@end
