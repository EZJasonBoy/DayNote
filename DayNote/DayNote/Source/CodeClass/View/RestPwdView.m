//
//  RestPwdView.m
//  YewNoteMe
//
//  Created by youyou on 15/10/17.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "RestPwdView.h"

@implementation RestPwdView

- (UILabel *)emailLabel
{
    if (_emailLabel == nil) {
        _emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, 80, 30)];
        [self addSubview:_emailLabel];
    }
    return _emailLabel;
}

- (UITextField *)emailTextField
{
    if (_emailTextField == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.emailLabel.frame), CGRectGetMinY(self.emailLabel.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) - 140, CGRectGetHeight(self.emailLabel.frame)+1)];
        view.backgroundColor = [UIColor grayColor];
        [self addSubview:view];
        _emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 140, CGRectGetHeight(self.emailLabel.frame))];
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.backgroundColor = [UIColor whiteColor];
        [view addSubview:_emailTextField];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.emailLabel.frame), CGRectGetMaxY(self.emailLabel.frame)+7, CGRectGetWidth(self.emailLabel.frame)+CGRectGetWidth(self.emailTextField.frame), 25)];
        label.font = [UIFont fontWithName:@"Menlo" size:11];
        label.textColor = [UIColor colorWithWhite:0.352 alpha:0.980];
        label.text = @"点击下一步后,请登录邮箱查收修改密码邮件";
        [self addSubview:label];
    }
    return _emailTextField;
}

- (UIButton *)cancleBtn
{
    if (_cancleBtn == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), [UIScreen mainScreen].bounds.size.width, 20)];
        _backView.backgroundColor = [UIColor flatBlueColor];
        [self addSubview:_backView];
        _cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.backView.frame), CGRectGetMaxY(self.backView.frame), [UIScreen mainScreen].bounds.size.width/2, 40)];
        [_cancleBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.239 green:0.318 blue:0.569 alpha:0.930]] forState:UIControlStateHighlighted];
        [self addSubview:_cancleBtn];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMinY(self.cancleBtn.frame), CGRectGetWidth(self.cancleBtn.frame), CGRectGetHeight(self.cancleBtn.frame))];
        [_sureBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.239 green:0.318 blue:0.569 alpha:0.930]] forState:UIControlStateHighlighted];
        [self addSubview:_sureBtn];
    }
    return _sureBtn;
}

@end
