//
//  AddDiaryView.h
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddDiaryViewDelegate <NSObject>

- (void)backToView:(BOOL)isOK;


@end

@interface AddDiaryView : UIView

@property (nonatomic, assign) id<AddDiaryViewDelegate>delegate;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UILabel *datelabel;
@property (nonatomic, strong) UIButton *moodSelect;
@property (nonatomic, strong) UIImageView *weatherShow;

@property (nonatomic, strong) UITextView *editPage;

@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *ok;

@end
