//
//  AddDiaryView.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
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
        _datelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 90,32)];
        [self.backGroundView addSubview:_datelabel];
        _datelabel.backgroundColor = [UIColor flatPurpleColor];
    }
    return _datelabel;
}

- (UIButton *)moodSelect {
    if (!_moodSelect) {
        _moodSelect = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 50,32)];
        [self.backGroundView addSubview:_moodSelect];
        _moodSelect.backgroundColor = [UIColor flatPurpleColor];
    }
    return _moodSelect;
}

- (UIImageView *)weatherShow {
    if (!_weatherShow) {
        _weatherShow = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 50,32)];
        _weatherShow.backgroundColor = [UIColor flatPurpleColor];
        [self.backGroundView addSubview:_weatherShow];
    }
    return _weatherShow;
}
- (UITextView *)editPage {
    if (!_editPage) {
        _editPage = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.datelabel.frame)-10, CGRectGetMaxY(self.datelabel.frame)+10, CGRectGetWidth(self.frame), 319)];
        _editPage.editable = YES;
        _editPage.scrollEnabled = YES;
        
        _editPage.returnKeyType = UIReturnKeyDefault;
        _editPage.keyboardType = UIKeyboardTypeNamePhonePad;
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

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)-44, 375, 44)];
        [_toolBar setBarStyle:UIBarStyleDefault];
        
        UIBarButtonItem * button1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wrong"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
        UIBarButtonItem * button2 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * button3 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * button4 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * button5 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * button6 =[[UIBarButtonItem  alloc] initWithImage:[UIImage imageNamed:@"check"] style:UIBarButtonItemStylePlain target:self action:@selector(ok:)];
        [_toolBar setItems:@[button1,button2,button3,button4,button5,button6]];
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

@end
