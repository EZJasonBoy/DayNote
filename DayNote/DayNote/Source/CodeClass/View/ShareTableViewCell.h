//
//  ShareTableViewCell.h
//  DayNote
//
//  Created by boluchuling on 15/10/26.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *createDate;
@property (strong, nonatomic) UILabel *weather;
@property (strong, nonatomic) UILabel *mood;
@property (strong, nonatomic) UILabel *diaryBody;
@property (strong, nonatomic) UILabel *placetext;
@property (strong, nonatomic) UILabel *city;



@end
