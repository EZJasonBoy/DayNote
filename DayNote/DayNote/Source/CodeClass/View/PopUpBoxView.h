//
//  MyNavigationView.h
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PopUpBoxViewDelegate <NSObject>

- (void)signIn;

- (void)intoUserCenter;

- (void)intoSetting;

@end

@interface PopUpBoxView : UIView

@property (nonatomic, strong) id<PopUpBoxViewDelegate>delegate;
@property (nonatomic, strong) UIButton *signIn;
@property (nonatomic, strong) UIButton *userInfo;
@property (nonatomic, strong) UIButton *setting;

@end
