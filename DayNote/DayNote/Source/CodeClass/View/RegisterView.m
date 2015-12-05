//
//  RegisterView.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import "RegisterView.h"

#define VIEWFRAME 
@implementation RegisterView

- (instancetype)init {
    if (self = [super init]) {
        [self p_setUI];
    }
    return self;
}

- (void)p_setUI {
    
    _UserNameLable = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*15/667, [UIScreen mainScreen].bounds.size.height*120/667, [UIScreen mainScreen].bounds.size.height*100/667, [UIScreen mainScreen].bounds.size.height*40/667)];
    [self addSubview:_UserNameLable];
    
    UIView *viewM = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.UserNameLable.frame) + [UIScreen mainScreen].bounds.size.height*5/667, CGRectGetMinY(self.UserNameLable.frame)+[UIScreen mainScreen].bounds.size.height*4/667, CGRectGetWidth([[UIScreen mainScreen] bounds]) - CGRectGetWidth(self.UserNameLable.frame) - [UIScreen mainScreen].bounds.size.height*70/667, CGRectGetHeight(self.UserNameLable.frame)-[UIScreen mainScreen].bounds.size.height*7/667)];
    viewM.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.860];
    [self addSubview:viewM];
    
    _UserNameText = [[UITextField alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth([[UIScreen mainScreen] bounds]) - CGRectGetWidth(self.UserNameLable.frame) - [UIScreen mainScreen].bounds.size.height*70/667, CGRectGetHeight(self.UserNameLable.frame)-[UIScreen mainScreen].bounds.size.height*8/667)];
    _UserNameText.backgroundColor = [UIColor whiteColor];
    [viewM addSubview:_UserNameText];
    
    _UserNull = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(viewM.frame) + [UIScreen mainScreen].bounds.size.height*10/667, CGRectGetMinY(viewM.frame), [UIScreen mainScreen].bounds.size.height*10/667, CGRectGetHeight(viewM.frame))];
    [self addSubview:_UserNull];
    
    
    _PwdLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.UserNameLable.frame), CGRectGetMaxY(self.UserNameLable.frame) + [UIScreen mainScreen].bounds.size.height*40/667, CGRectGetWidth(self.UserNameLable.frame), CGRectGetHeight(self.UserNameLable.frame))];
    
    [self addSubview:_PwdLable];
    
    UIView *viewM1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(viewM.frame), CGRectGetMaxY(viewM.frame) + [UIScreen mainScreen].bounds.size.height*44/667, CGRectGetWidth(viewM.frame), CGRectGetHeight(viewM.frame)+[UIScreen mainScreen].bounds.size.height*1/667)];
    viewM1.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.860];
    [self addSubview:viewM1];
    
    _PwdText = [[UITextField alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth(viewM.frame), CGRectGetHeight(viewM.frame))];
    _PwdText.backgroundColor = [UIColor whiteColor];
    [viewM1 addSubview:_PwdText];
    
    _PwdrNull = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(viewM1.frame) + [UIScreen mainScreen].bounds.size.height*10/667, CGRectGetMinY(viewM1.frame), CGRectGetWidth(self.UserNull.frame), CGRectGetHeight(viewM1.frame))];
    [self addSubview:_PwdrNull];
    
    
    _AgainPwdLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.PwdLable.frame), CGRectGetMaxY(self.PwdLable.frame) + [UIScreen mainScreen].bounds.size.height*40/667, CGRectGetWidth(self.PwdLable.frame), CGRectGetHeight(self.PwdLable.frame))];
    [self addSubview:_AgainPwdLable];
    UIView *viewM2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(viewM1.frame), CGRectGetMaxY(viewM1.frame) + [UIScreen mainScreen].bounds.size.height*44/667, CGRectGetWidth(viewM1.frame), CGRectGetHeight(viewM1.frame)+[UIScreen mainScreen].bounds.size.height*1/667)];
    viewM2.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.860];
    [self addSubview:viewM2];
    
    _AgainPwdText = [[UITextField alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth(viewM1.frame), CGRectGetHeight(viewM1.frame))];
    _AgainPwdText.backgroundColor = [UIColor whiteColor];
    [viewM2 addSubview:_AgainPwdText];
    
    _AgainPwdNull = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(viewM2.frame) + [UIScreen mainScreen].bounds.size.height*10/667, CGRectGetMinY(viewM2.frame), CGRectGetWidth(self.UserNull.frame), CGRectGetHeight(self.UserNull.frame))];
    [self addSubview:_AgainPwdNull];
    
    
    
    
    
    
    _MailLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.AgainPwdLable.frame), CGRectGetMaxY(self.AgainPwdLable.frame) + [UIScreen mainScreen].bounds.size.height*40/667, CGRectGetWidth(self.AgainPwdLable.frame), CGRectGetHeight(self.AgainPwdLable.frame))];
    [self addSubview:_MailLable];
    
    UIView *viewM3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(viewM2.frame), CGRectGetMaxY(viewM2.frame) + [UIScreen mainScreen].bounds.size.height*44/667, CGRectGetWidth(viewM2.frame), CGRectGetHeight(viewM2.frame)+[UIScreen mainScreen].bounds.size.height*1/667)];
    viewM3.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.860];
    [self addSubview:viewM3];
    
    _MailText = [[UITextField alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth(viewM2.frame), CGRectGetHeight(viewM2.frame))];
    _MailText.backgroundColor = [UIColor whiteColor];
    [viewM3 addSubview:_MailText];
    
    _MailNull = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(viewM3.frame) + [UIScreen mainScreen].bounds.size.height*10/667, CGRectGetMinY(viewM3.frame), CGRectGetWidth(self.AgainPwdNull.frame), CGRectGetHeight(self.AgainPwdNull.frame))];
    [self addSubview:_MailNull ];
    
    
    
    self.UserNameLable.text = @"用 户 名:";
    self.UserNameLable.textAlignment = NSTextAlignmentCenter;
    self.UserNameText.placeholder = @"请输入用户名";

    
    self.PwdLable.text = @"密       码:";
    self.PwdLable.textAlignment = NSTextAlignmentCenter;
    self.PwdText.placeholder = @"请输入密码";
    self.PwdText.secureTextEntry = YES;
    
    self.AgainPwdLable.text = @"确认密码:";
    self.AgainPwdLable.textAlignment = NSTextAlignmentCenter;
    self.AgainPwdText.placeholder = @"请输入确认密码";
    self.AgainPwdText.secureTextEntry = YES;
    
    self.MailLable.text = @"邮       箱:";
    self.MailLable.textAlignment = NSTextAlignmentCenter;
    self.MailText.placeholder = @"邮箱名@xx.com";
    self.MailNull.text = @"*";
    self.MailNull.textColor = [UIColor redColor];
    
    
    [self.cancelBtn setTitle:@"重置" forState:UIControlStateNormal];
    self.cancelBtn.layer.borderColor = [UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:1.000].CGColor;
    self.cancelBtn.layer.borderWidth = 1;

    [self.cancelBtn addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.registerBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.UserNull.text = @"*";
    self.UserNull.textColor = [UIColor redColor];
    
    self.PwdrNull.text = @"*";
    self.PwdrNull.textColor = [UIColor redColor];
    self.AgainPwdNull.text = @"*";
    self.AgainPwdNull.textColor = [UIColor redColor];
}

-(UIButton *)cancelBtn
{
    if (_cancelBtn == nil)
    {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.MailLable.frame)+[UIScreen mainScreen].bounds.size.height*12/667, CGRectGetMaxY(self.MailLable.frame) + [UIScreen mainScreen].bounds.size.height*60/667, [UIScreen mainScreen].bounds.size.height*120/667, CGRectGetHeight(self.MailLable.frame))];
        _cancelBtn.layer.cornerRadius = 3;
        [_cancelBtn setTitleColor:[UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:1.000] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

-(UIButton *)registerBtn
{
    if (_registerBtn == nil)
    {
        _registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cancelBtn.frame) + [UIScreen mainScreen].bounds.size.height*65/667, CGRectGetMinY(self.cancelBtn.frame), CGRectGetWidth(self.cancelBtn.frame), CGRectGetHeight(self.cancelBtn.frame))];
        _registerBtn.layer.cornerRadius = 3;
        _registerBtn.backgroundColor = [UIColor colorWithRed:0.176 green:0.243 blue:0.506 alpha:0.840];
        [self addSubview:_registerBtn];
    }
    return _registerBtn;
}


//重置事件
-(void)resetAction:(UIButton *)sender
{
    [self.delegate reset];
}
//确定事件
-(void)loginAction:(UIButton *)sender
{
    [self.delegate login];
}

@end
