//
//  AddDiaryView.m
//  DayNote
//
//  Created by boluchuling on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AddDiaryView.h"

@implementation AddDiaryView

- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}

- (UILabel *)datelabel {
    if (!_datelabel) {
        _datelabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*30/667, [UIScreen mainScreen].bounds.size.height*10/667, 90,[UIScreen mainScreen].bounds.size.height*37/667)];
        [self.backGroundView addSubview:_datelabel];
    }
    return _datelabel;
}

- (UIImageView *)weatherShow {
    if (!_weatherShow) {
        _weatherShow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.datelabel.frame)+[UIScreen mainScreen].bounds.size.height*20/667, CGRectGetMinY(self.datelabel.frame), [UIScreen mainScreen].bounds.size.height*42/667,CGRectGetHeight(self.datelabel.frame))];
        [self.backGroundView addSubview:_weatherShow];
    }
    return _weatherShow;
}

- (UILabel *)weatherText {
    if (!_weatherText) {
        _weatherText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.weatherShow.frame), CGRectGetMinY(self.weatherShow.frame), CGRectGetWidth(self.weatherShow.frame)+[UIScreen mainScreen].bounds.size.height*20/667, CGRectGetHeight(self.weatherShow.frame))];
        [self.backGroundView addSubview:_weatherText];
    }
    return _weatherText;
}

- (UIButton *)moodSmaile {
    if (!_moodSmaile) {
        _moodSmaile = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*280/667, [UIScreen mainScreen].bounds.size.height*10/667, [UIScreen mainScreen].bounds.size.height*42/667,[UIScreen mainScreen].bounds.size.height*37/667)];
        _moodSmaile.titleLabel.text = @"高兴";
        _moodSmaile.tag = 1001;
        [_moodSmaile addTarget:self action:@selector(smaile:) forControlEvents:UIControlEventTouchUpInside];
        [_moodSmaile setImage:[UIImage imageNamed:@"高兴"] forState:UIControlStateNormal];
        [self.backGroundView addSubview:_moodSmaile];

    }
    return _moodSmaile;
}
- (UIButton *)moodCry {
    if (!_moodCry) {
        _moodCry = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*280/667, [UIScreen mainScreen].bounds.size.height*10/667, [UIScreen mainScreen].bounds.size.height*42/667,[UIScreen mainScreen].bounds.size.height*37/667)];
        _moodCry.tag = 1002;
        [_moodCry addTarget:self action:@selector(cry:) forControlEvents:UIControlEventTouchUpInside];
        [_moodCry setImage:[UIImage imageNamed:@"难过"] forState:UIControlStateNormal];
        _moodCry.titleLabel.text = @"难过";
        [self.backGroundView addSubview:_moodCry];
    }
    return _moodCry;
}
- (UIButton *)moodFlat {
    if (!_moodFlat) {
        _moodFlat = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*280/667, [UIScreen mainScreen].bounds.size.height*10/667, [UIScreen mainScreen].bounds.size.height*42/667,[UIScreen mainScreen].bounds.size.height*37/667)];
        _moodFlat.tag = 1003;
        [_moodFlat addTarget:self action:@selector(flat:) forControlEvents:UIControlEventTouchUpInside];
        [_moodFlat setImage:[UIImage imageNamed:@"平淡"] forState:UIControlStateNormal];
        _moodFlat.titleLabel.text = @"平淡";
        [self.backGroundView addSubview:_moodFlat];
       
    }
    return _moodFlat;
}

- (UILabel *)moodText {
    if (!_moodText) {
        _moodText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moodFlat.frame), CGRectGetMinY(self.moodFlat.frame), CGRectGetWidth(self.moodFlat.frame)+[UIScreen mainScreen].bounds.size.height*10/667, CGRectGetHeight(self.moodFlat.frame))];
        [self.backGroundView addSubview:_moodText];
    }
    return _moodText;
}

- (UITextView *)editPage {
    if (!_editPage) {
        _editPage = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.datelabel.frame)-[UIScreen mainScreen].bounds.size.height*29/667, CGRectGetMaxY(self.datelabel.frame)+[UIScreen mainScreen].bounds.size.height*10/667, CGRectGetWidth(self.frame), [UIScreen mainScreen].bounds.size.height*299/667)];
        _editPage.editable = YES;
        _editPage.scrollEnabled = YES;
        _editPage.keyboardType = UIKeyboardTypeDefault;
        _editPage.textAlignment = NSTextAlignmentLeft;
        _editPage.font = [UIFont fontWithName:@"Melno" size:30];
        _editPage.dataDetectorTypes = UIDataDetectorTypeAll;
        _editPage.font = [UIFont fontWithName:@"Menlo" size:14];
        _editPage.backgroundColor = [UIColor flatWhiteColor];
        _editPage.textContainer.lineBreakMode = NSLineBreakByClipping;
        [self.backGroundView addSubview:_editPage];

    }
    return _editPage;
}

- (UIImageView *)myImage {
    if (!_myImage) {
        _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.editPage.frame)+[UIScreen mainScreen].bounds.size.height*5/667, CGRectGetMaxY(self.editPage.frame)+[UIScreen mainScreen].bounds.size.height*10/667, [UIScreen mainScreen].bounds.size.height*150/667, [UIScreen mainScreen].bounds.size.height*150/667)];
        [self.backGroundView addSubview:_myImage];
    }
    return _myImage;
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds)* (CGRectGetMaxY(self.frame)-64)/667, CGRectGetWidth([UIScreen mainScreen].bounds), [UIScreen mainScreen].bounds.size.height*44/667)];
        [_toolBar setBarStyle:UIBarStyleDefault];
        
        UIBarButtonItem * button1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wrong"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
        
        UIBarButtonItem *place1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem * button2 =[[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:@"text_minus"] style:UIBarButtonItemStylePlain target:self action:@selector(zoomOutFont:)];
        UIBarButtonItem * button3 =[[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:@"text_plus"] style:UIBarButtonItemStylePlain target:self action:@selector(zoomInFont:)];
        UIBarButtonItem *place2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem * button4 =[[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:@"sound"] style:UIBarButtonItemStylePlain target:self action:@selector(record:)];
        
        UIBarButtonItem *place3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem * button5 =[[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:@"picture"] style:UIBarButtonItemStylePlain target:self action:@selector(choosePhoto:)];
        UIBarButtonItem *place4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem * button6 =[[UIBarButtonItem  alloc] initWithImage:[UIImage imageNamed:@"check"] style:UIBarButtonItemStylePlain target:self action:@selector(ok:)];
        [_toolBar setItems:@[button1,place1,button2,button3,place2,button4,place3,button5,place4,button6]];
        [self.backGroundView addSubview:_toolBar];
    }
    return _toolBar;
}

- (void)cancel:(UIBarButtonItem *)sender {
    [self.delegate backToView:NO];
}

- (void)ok:(UIBarButtonItem *)sender {
    [self.delegate backToView:YES];
}

- (void)record:(UIBarButtonItem *)sender {
    [self.delegate recording:sender];
}

- (void)zoomOutFont:(UIBarButtonItem *)sender {
    [self.delegate zoomInOrOutFont:NO];
}

- (void)zoomInFont:(UIBarButtonItem *)sender {
    [self.delegate zoomInOrOutFont:YES];
}

- (void)choosePhoto:(UIBarButtonItem *)sender {
    [self.delegate choosePhotos];
}

- (void)smaile:(UIButton *)sender {
    [self.delegate chooseMood:sender];
}

- (void)cry:(UIButton *)sender {
    [self.delegate chooseMood:sender];
}

- (void)flat:(UIButton *)sender {
    [self.delegate chooseMood:sender];
}
@end
