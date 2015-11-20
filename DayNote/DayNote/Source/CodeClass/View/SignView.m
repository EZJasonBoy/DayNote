//
//  SignView.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "SignView.h"

@implementation SignView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setView];
        // self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)p_setView
{
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, 70, 40)];
    self.userLabel.backgroundColor = [UIColor clearColor];
    self.userLabel.text = @"用户名:";
    [self addSubview:_userLabel];
    
    UIView *backview1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userLabel.frame) + 5, CGRectGetMinY(self.userLabel.frame)+1, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 135, 33)];
    backview1.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.900];
    [self addSubview:backview1];
    self.userTextField = [[UITextField alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 135, 32)];
    self.userTextField.backgroundColor = [UIColor whiteColor];
    self.userTextField.keyboardType = UIKeyboardTypeDefault;
    self.userTextField.placeholder = @"请输入用户名";
    self.userTextField.borderStyle = UITextBorderStyleNone;
    [backview1 addSubview:_userTextField];
    
    
    
    
    self.pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLabel.frame), CGRectGetMaxY(self.userLabel.frame) + 20, CGRectGetWidth(self.userLabel.frame), CGRectGetHeight(self.userLabel.frame))];
    self.pwdLabel.backgroundColor = [UIColor clearColor];
    self.pwdLabel.text = @"密    码:";
    [self addSubview:_pwdLabel];
    
    UIView *backview2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.pwdLabel.frame) + 5, CGRectGetMinY(self.pwdLabel.frame)+1, CGRectGetWidth(self.userTextField.frame), CGRectGetHeight(self.userTextField.frame)+1)];
    backview2.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.900];
    [self addSubview:backview2];
    
    self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.userTextField.frame), CGRectGetHeight(self.userTextField.frame))];
    self.pwdTextField.backgroundColor = [UIColor whiteColor];
    self.pwdTextField.placeholder = @"请输入密码";
    self.pwdTextField.borderStyle = UITextBorderStyleNone;
    self.pwdTextField.secureTextEntry = YES;
    [backview2 addSubview:_pwdTextField];
    
    
    self.signBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pwdLabel.frame)-10, CGRectGetMaxY(self.pwdLabel.frame) + 50, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 40, 45)];
    self.signBtn.layer.cornerRadius = 5;
    [self.signBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.signBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.253 green:0.338 blue:0.608 alpha:0.530]] forState:UIControlStateNormal];
//    self.signBtn.backgroundColor = [UIColor colorWithRed:0.253 green:0.338 blue:0.608 alpha:0.530];
    [self addSubview:_signBtn];
    
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.signBtn.frame), CGRectGetMaxY(self.signBtn.frame) + 20, CGRectGetWidth(self.signBtn.frame), CGRectGetHeight(self.signBtn.frame))];
    self.loginBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.borderColor = [UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:1.000].CGColor;
    self.loginBtn.layer.borderWidth = 1;
    [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:1.000] forState:UIControlStateNormal];
    self.loginBtn.tintColor = [UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:1.000];
    
    [self addSubview:_loginBtn];
}

@end
