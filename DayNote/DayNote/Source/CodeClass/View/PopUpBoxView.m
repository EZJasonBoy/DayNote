//
//  MyNavigationView.m
//  DayNote
//
//  Created by boluchuling on 15/10/15.
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
    
    self.menu = [UIButton buttonWithType:UIButtonTypeSystem];
    self.menu.frame = CGRectMake(0, 25, 37, 30);
    [self.menu setImage:[UIImage imageNamed:@"ic_menu"] forState:UIControlStateNormal];
    [self.menu addTarget:self action:@selector(backToMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_menu];
    
    self.signIn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signIn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*110.5/375,[UIScreen mainScreen].bounds.size.width*150/375, [UIScreen mainScreen].bounds.size.width*150/375, [UIScreen mainScreen].bounds.size.height*40/667);
    self.signIn.font = [UIFont fontWithName:@"Menlo" size:20];
    [self.signIn addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.signIn setTitle:@"登录" forState:UIControlStateNormal];
    [self addSubview:_signIn];
  
    
    self.userInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userInfo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*132.5/375,CGRectGetMaxY(self.signIn.frame)+25, [UIScreen mainScreen].bounds.size.width*100/375, CGRectGetHeight(self.signIn.frame));
    [self.userInfo addTarget:self action:@selector(intoUserCenter:) forControlEvents:UIControlEventTouchUpInside];
    [self.userInfo setTitle:@"个人中心" forState:UIControlStateNormal];
    [self addSubview:_userInfo];
    
    self.setting = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setting.frame = CGRectMake(CGRectGetMinX(self.userInfo.frame),CGRectGetMaxY(self.userInfo.frame)+25, CGRectGetWidth(self.userInfo.frame), CGRectGetHeight(self.userInfo.frame));
    [self.setting addTarget:self action:@selector(intoSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.setting setTitle:@"设置" forState:UIControlStateNormal];
    [self addSubview:_setting];
    
    
    self.yiImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"已"]];
   
    self.yiImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*30/375,[UIScreen mainScreen].bounds.size.height*520/667, [UIScreen mainScreen].bounds.size.width*50/375, [UIScreen mainScreen].bounds.size.width*50/375);
    [self addSubview:_yiImageView];
    
    self.jianImageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"坚"]];
    self.jianImageVIew.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*90/375,[UIScreen mainScreen].bounds.size.height*450/667, CGRectGetWidth(self.yiImageView.frame), CGRectGetHeight(self.yiImageView.frame));
    [self addSubview:_jianImageVIew];
    
    self.chiImageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"持"]];
    self.chiImageVIew.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*155/375, [UIScreen mainScreen].bounds.size.height*420/667, CGRectGetWidth(self.jianImageVIew.frame), CGRectGetHeight(self.jianImageVIew.frame));
    [self addSubview:_chiImageVIew];
    
    self.tianImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"天"]];
    self.tianImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.height*300/667, [UIScreen mainScreen].bounds.size.height*550/667, CGRectGetWidth(self.chiImageVIew.frame), CGRectGetHeight(self.chiImageVIew.frame));
    [self addSubview:_tianImageView];
    
    self.dayCount = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*85/667, [UIScreen mainScreen].bounds.size.height*530/667, [UIScreen mainScreen].bounds.size.height*215/667, CGRectGetWidth(self.tianImageView.frame))];
    self.dayCount.text = @"108";
    self.dayCount.textAlignment = NSTextAlignmentCenter;
    self.dayCount.font = [UIFont fontWithName:@"Menlo" size:55];
    [self addSubview:_dayCount];
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

- (void)backToMainView:(UIButton *)sender {
    [self.delegate backToNext:sender];
}

@end
