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
    self.backgroundColor = [UIColor redColor];
    
    UIButton *signIn = [UIButton buttonWithType:UIButtonTypeCustom];
    signIn.frame = CGRectMake(-8,5, 70, 33);
    [signIn addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    [signIn setTitle:@"登录" forState:UIControlStateNormal];
    [self addSubview:signIn];
    
    UIButton *userInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    userInfo.frame = CGRectMake(CGRectGetMinX(signIn.frame),CGRectGetMaxY(signIn.frame)+10, 100, 33);
    [userInfo addTarget:self action:@selector(intoUserCenter:) forControlEvents:UIControlEventTouchUpInside];
    [userInfo setTitle:@"个人中心" forState:UIControlStateNormal];
    [self addSubview:userInfo];
    
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
    setting.frame = CGRectMake(CGRectGetMinX(userInfo.frame),CGRectGetMaxY(userInfo.frame)+10, 70, 33);
    [setting addTarget:self action:@selector(intoSetting:) forControlEvents:UIControlEventTouchUpInside];
    [setting setTitle:@"设置" forState:UIControlStateNormal];
    [self addSubview:setting];
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
