//
//  UserInfoView.h
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoView : UIView
@property(nonatomic,strong)UIImageView *bgImg;
@property(nonatomic,strong)UIImageView *heardImg;

@property(nonatomic,strong)UIButton *editBtn;

@property(nonatomic,strong)UIScrollView *infoScroll;
@property(nonatomic,strong)UILabel *UserNameLable;
@property(nonatomic,strong)UITextField *UserNameText;
@property(nonatomic,strong)UILabel *genderLable;
@property(nonatomic,strong)UITextField *genderText;
@property(nonatomic,strong)UILabel *ageLable;
@property(nonatomic,strong)UITextField *ageText;
@property(nonatomic,strong)UILabel *SignLable;
@property(nonatomic,strong)UITextField *SignText;
@end
