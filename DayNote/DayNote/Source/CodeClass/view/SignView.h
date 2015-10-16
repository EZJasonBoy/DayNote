//
//  SignView.h
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignView : UIView


@property (nonatomic,strong)UILabel *userLabel;
@property (nonatomic,strong)UILabel *pwdLabel;

@property (nonatomic,strong)UITextField *userTextField;
@property (nonatomic,strong)UITextField *pwdTextField;

@property (nonatomic,strong)UIButton *signBtn;
@property (nonatomic,strong)UIButton *loginBtn;

@end
