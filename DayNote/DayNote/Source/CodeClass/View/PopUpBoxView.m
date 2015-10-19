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
    self.signIn.frame = CGRectMake(132.5,100, 100, 32);
    [self.signIn addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.signIn setTitle:@"登录" forState:UIControlStateNormal];
    [self addSubview:_signIn];
  
    
    self.userInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userInfo.frame = CGRectMake(132.5,CGRectGetMaxY(self.signIn.frame)+20, 100, 32);
    [self.userInfo addTarget:self action:@selector(intoUserCenter:) forControlEvents:UIControlEventTouchUpInside];
    [self.userInfo setTitle:@"个人中心" forState:UIControlStateNormal];
    [self addSubview:_userInfo];
    
    self.setting = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setting.frame = CGRectMake(132.5,CGRectGetMaxY(self.userInfo.frame)+20, 100, 32);
    [self.setting addTarget:self action:@selector(intoSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.setting setTitle:@"设置" forState:UIControlStateNormal];
    [self addSubview:_setting];
    
    
    self.circleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), 52, 52)];
    self.circleImage.backgroundColor = [UIColor clearColor];
    self.circleImage.image = [UIImage imageNamed:@"/Users/lanou3g/Desktop/素材/图标(png)/对与错/半圆白.png"];
    [self addSubview:self.circleImage];

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
