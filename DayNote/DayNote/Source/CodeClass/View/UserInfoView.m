//
//  UserInfoView.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView

-(instancetype)init
{
    if (self = [super init])
    {
        [self p_data];
    }
    return self;
}
-(void)p_data
{
    _bgImg =[ [UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]),300)];
    _bgImg.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgImg];
    
    
    _heardImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bgImg.frame) + CGRectGetWidth(self.bgImg.frame)/10,CGRectGetHeight(self.bgImg.frame)/10-20, CGRectGetHeight(self.bgImg.frame) - 130,  CGRectGetHeight(self.bgImg.frame) - 130)];
    _heardImg.backgroundColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    _heardImg.layer.cornerRadius = CGRectGetWidth(self.heardImg.frame)/2;
    CGPoint center = self.bgImg.center;
    center.y += 20;
    _heardImg.center = center;
    _heardImg.layer.masksToBounds = YES;
    _heardImg.userInteractionEnabled = YES;
    self.heardImg.image = [UIImage imageNamed:@"header.png"];
    [self addSubview:_heardImg];
    
    
    _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bgImg.frame)-80, CGRectGetMaxY(self.bgImg.frame) - 35, 60, 30)];
    _editBtn.layer.cornerRadius = 5;
    _editBtn.clipsToBounds = YES;
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    
    _editBtn.backgroundColor = [UIColor colorWithRed:102/255.0 green:205/255.0 blue:170/255.0 alpha:1];
    [self addSubview:_editBtn];       
    
    _infoScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bgImg.frame), CGRectGetMaxY(self.bgImg.frame), CGRectGetWidth(self.bgImg.frame), CGRectGetHeight([[UIScreen mainScreen] bounds]) - CGRectGetHeight(self.bgImg.frame) )];
    _infoScroll.backgroundColor = [UIColor whiteColor];
    _infoScroll.userInteractionEnabled = YES;
    _infoScroll.contentSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), 367);
    [self addSubview:_infoScroll];
    
    
    _UserNameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bgImg.frame) + 40, 40, 100, 40)];
    [self.infoScroll addSubview:_UserNameLable];
    _UserNameLable.text = @"昵 称:";
    _UserNameLable.tag = 1110;
    _UserNameLable.textAlignment = NSTextAlignmentCenter;
    
   

     _UserNameText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.UserNameLable.frame) + 10, CGRectGetMinY(self.UserNameLable.frame), CGRectGetWidth([[UIScreen mainScreen] bounds]) - CGRectGetWidth(self.UserNameLable.frame) - 100, CGRectGetHeight(self.UserNameLable.frame))];
    _UserNameText.borderStyle = UITextBorderStyleRoundedRect;
    _UserNameText.placeholder = @"起个昵称吧!";
    _UserNameText.tag = 11101110;
    [self.infoScroll addSubview:_UserNameText];

    _genderLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.UserNameLable.frame), CGRectGetMaxY(self.UserNameLable.frame) + 20, CGRectGetWidth(self.UserNameLable.frame), CGRectGetHeight(self.UserNameLable.frame))];
    _genderLable.tag = 2220;
    [self.infoScroll addSubview:_genderLable];
    
    _genderText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.UserNameText.frame), CGRectGetMaxY(self.UserNameText.frame) + 20, CGRectGetWidth(self.UserNameText.frame), CGRectGetHeight(self.UserNameText.frame))];
    _genderText.tag = 22202220;
    [self.infoScroll addSubview:_genderText];
    _genderLable.text = @"性 别:";
    _genderText.placeholder =@"保密";
    _genderLable.textAlignment = NSTextAlignmentCenter;
    _genderText.borderStyle = UITextBorderStyleRoundedRect;
    
    _ageLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.genderLable.frame), CGRectGetMaxY(self.genderLable.frame) + 20, CGRectGetWidth(self.genderLable.frame), CGRectGetHeight(self.genderLable.frame))];
    _ageLable.text = @"生 日:";
    _ageLable.tag = 3330;
    _ageLable.textAlignment = NSTextAlignmentCenter;
    _ageText.borderStyle = UITextBorderStyleRoundedRect;
    _ageText.placeholder = @"mm-dd";
    [self.infoScroll addSubview:_ageLable];
    
    _ageText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.genderText.frame), CGRectGetMaxY(self.genderText.frame) + 20, CGRectGetWidth(self.genderText.frame), CGRectGetHeight(self.genderText.frame))];
    _ageText.tag = 33303330;
    [self.infoScroll addSubview:_ageText];
    
    _SignLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.ageLable.frame), CGRectGetMaxY(self.ageLable.frame) + 20, CGRectGetWidth(self.ageLable.frame), CGRectGetHeight(self.ageLable.frame))];
    _SignLable.tag = 4440;
    [self.infoScroll addSubview:_SignLable];
    
    _SignText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.ageText.frame), CGRectGetMaxY(self.ageText.frame) + 20, CGRectGetWidth(self.ageText.frame), CGRectGetHeight(self.ageText.frame))];
    _SignLable.text = @"签 名:";
    _SignText.tag = 44404440;
    _SignLable.textAlignment = NSTextAlignmentCenter;
    _SignText.borderStyle = UITextBorderStyleRoundedRect;
    _SignText.placeholder = @"写个签名吧!";
    [self.infoScroll addSubview:_SignText];
    
    
    _UserNameText.userInteractionEnabled = NO;
    _UserNameText.borderStyle = UITextBorderStyleNone;
    _genderText.userInteractionEnabled = NO;
    _genderText.borderStyle = UITextBorderStyleNone;    
    _ageText.userInteractionEnabled = NO;
    _ageText.borderStyle = UITextBorderStyleNone;    
    _SignText.userInteractionEnabled = NO;
    _SignText.borderStyle = UITextBorderStyleNone;   
}
@end
