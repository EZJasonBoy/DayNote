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

- (void)backToNext:(UIButton *)sender;

@end

@interface PopUpBoxView : UIView

@property (nonatomic, assign) id<PopUpBoxViewDelegate>delegate;

@property (nonatomic, strong) UIButton *menu;
@property (nonatomic, strong) UIButton *signIn;
@property (nonatomic, strong) UIButton *userInfo;
@property (nonatomic, strong) UIButton *setting;

@property (nonatomic, strong) UIImageView *yiImageView;
@property (nonatomic, strong) UIImageView *jianImageVIew;
@property (nonatomic, strong) UIImageView *chiImageVIew;
@property (nonatomic, strong) UIImageView *tianImageView;

@property (nonatomic, strong) UIImageView *nextImageView;

@end
