//
//  AddDiaryView.h
//  DayNote
//
//  Created by boluchuling on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddDiaryViewDelegate <NSObject>

- (void)backToView:(BOOL)isOK;

- (void)chooseMood:(UIButton *)sender;

- (void)choosePhotos;

- (void)recording:(UIBarButtonItem *)sender;

- (void)zoomInOrOutFont:(BOOL)isReduce;

@end

@interface AddDiaryView : UIView

@property (nonatomic, assign) id<AddDiaryViewDelegate>delegate;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UILabel *datelabel;

@property (nonatomic, strong) UIButton *moodSmaile;
@property (nonatomic, strong) UIButton *moodCry;
@property (nonatomic, strong) UIButton *moodFlat;
@property (nonatomic, strong) UILabel *moodText;

@property (nonatomic, strong) UIImageView *weatherShow;
@property (nonatomic, strong) UILabel *weatherText;

@property (nonatomic, strong) UITextView *editPage;

@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *ok;

@property (nonatomic, strong) UIImageView *myImage;
@end
