//
//  MyNavigationView.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "PopUpBoxView.h"

@implementation PopUpBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setUp];
    }
    return self;
}

- (void)p_setUp {
    
    
    self.signIn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signIn.frame = CGRectMake(-8,5, 70, 33);
    [self.signIn addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.signIn setTitle:@"登录" forState:UIControlStateNormal];
    [self addSubview:_signIn];
    
    self.userInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userInfo.frame = CGRectMake(CGRectGetMinX(self.signIn.frame),CGRectGetMaxY(self.signIn.frame)+10, 100, 33);
    [self.userInfo addTarget:self action:@selector(intoUserCenter:) forControlEvents:UIControlEventTouchUpInside];
    [self.userInfo setTitle:@"个人中心" forState:UIControlStateNormal];
    [self addSubview:_userInfo];
    
    self.setting = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setting.frame = CGRectMake(CGRectGetMinX(self.userInfo.frame),CGRectGetMaxY(self.userInfo.frame)+10, 70, 33);
    [self.setting addTarget:self action:@selector(intoSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.setting setTitle:@"设置" forState:UIControlStateNormal];
    [self addSubview:_setting];
}

- (void)signIn:(UIButton *)sender {
    [self.delegate signIn];
}

- (void)intoUserCenter:(UIButton *)sender {
    [self.delegate intoUserCenter];
}

- (void)intoSetting:(UIButton *)sender {
    [self.delegate intoSetting];
}

@end
