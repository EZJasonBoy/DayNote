//
//  AddDiaryViewController.h
//  DayNote
//
//  Created by boluchuling on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ADDTYPE) {
    ADDTYPEInsert,
    ADDTYPEAdditional,
    ADDTYPEWriteUp
};

@interface AddDiaryViewController : UIViewController

@property (nonatomic, assign) ADDTYPE type;
//@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSDate *contentDate;

@end
