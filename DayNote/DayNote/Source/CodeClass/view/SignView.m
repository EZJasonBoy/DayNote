//
//  SignView.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
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
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 70, 40)];
    self.userLabel.backgroundColor = [UIColor purpleColor];
    self.userLabel.text = @"用户名：";
    [self addSubview:_userLabel];
    
    self.userTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLabel.frame) + 20, CGRectGetMinY(self.userLabel.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) - 130, CGRectGetHeight(self.userLabel.frame))];
    self.userTextField.backgroundColor = [UIColor grayColor];
    [self addSubview:_userTextField];
    
    
    self.pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLabel.frame), CGRectGetMaxY(self.userLabel.frame) + 20, CGRectGetWidth(self.userLabel.frame), CGRectGetHeight(self.userLabel.frame))];
    self.pwdLabel.backgroundColor = [UIColor purpleColor];
    self.pwdLabel.text = @"密码：";
    [self addSubview:_pwdLabel];
    self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pwdLabel.frame) + 20, CGRectGetMinY(self.pwdLabel.frame), CGRectGetWidth(self.userTextField.frame), CGRectGetHeight(self.userTextField.frame))];
    self.pwdTextField.backgroundColor = [UIColor grayColor];
    self.pwdTextField.secureTextEntry = YES;
    [self addSubview:_pwdTextField];
    
    
    self.signBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pwdLabel.frame), CGRectGetMaxY(self.pwdLabel.frame) + 50, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 40, 50)];
    [self.signBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.signBtn.backgroundColor = [UIColor purpleColor];
    [self addSubview:_signBtn];
    
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.signBtn.frame), CGRectGetMaxY(self.signBtn.frame) + 20, CGRectGetWidth(self.signBtn.frame), CGRectGetHeight(self.signBtn.frame))];
    [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor purpleColor];
    [self addSubview:_loginBtn];
}
@end
