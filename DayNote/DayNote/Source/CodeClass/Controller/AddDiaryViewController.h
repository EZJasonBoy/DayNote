//
//  AddDiaryViewController.h
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ADDTYPE) {
    ADDTYPEInsert,
    ADDTYPEAdditional
};

@interface AddDiaryViewController : UIViewController

@property (nonatomic, assign) ADDTYPE type;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSDate *contentDate;
@property (nonatomic, strong) NSString *diaryText;
@property (nonatomic, strong) NSString *mood;
@property (nonatomic, strong) NSString *weatherImage;

@end
