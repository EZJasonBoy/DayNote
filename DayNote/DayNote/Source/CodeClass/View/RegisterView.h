//
//  RegisterView.h
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewDelegate <NSObject>

- (void)reset;
- (void)login;

@end
@interface RegisterView : UIView
@property (nonatomic, assign) id<RegisterViewDelegate>delegate;

@property(nonatomic,strong)UILabel *UserNameLable;
@property(nonatomic,strong)UITextField *UserNameText;
@property(nonatomic,strong)UILabel *UserNull;

@property(nonatomic,strong)UILabel *PwdLable;
@property(nonatomic,strong)UITextField *PwdText;
@property(nonatomic,strong)UILabel *PwdrNull;

@property(nonatomic,strong)UILabel *AgainPwdLable;
@property(nonatomic,strong)UITextField *AgainPwdText;
@property(nonatomic,strong)UILabel *AgainPwdNull;

@property(nonatomic,strong)UILabel *MailLable;
@property(nonatomic,strong)UITextField *MailText;
@property(nonatomic,strong)UILabel *MailNull;

@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *cancelBtn;
@end
