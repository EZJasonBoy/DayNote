//
//  DiaryListTableViewCell.h
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryListTableViewCell : UITableViewCell
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *weatherLabel;

@property (strong, nonatomic) UIImageView *weatherImageView;
@property (strong, nonatomic) UILabel *moodLabel;
@property (strong, nonatomic) UIImageView *moodImageView;
@property (strong, nonatomic) UILabel *detailsText;




@end
