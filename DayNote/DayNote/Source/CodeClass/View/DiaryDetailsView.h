//
//  DiaryDetailsView.h
//  DayNote
//
//  Created by lanou3g on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DiaryDetailsViewDelegate <NSObject>

- (void)writeDiary;

@end
@interface DiaryDetailsView : UIView


@property (nonatomic, strong) id<DiaryDetailsViewDelegate>delegate;

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UIImageView *weatherImage;

@property (nonatomic, strong) UIImageView *moodImage;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *myImage;

@property (nonatomic, strong) UIButton *editButton;

@end
