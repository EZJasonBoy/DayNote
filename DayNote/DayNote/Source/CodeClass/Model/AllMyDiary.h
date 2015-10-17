//
//  AllMyDiary.h
//  DayNote
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AllMyDiary : NSManagedObject

@property (nonatomic, retain) NSDate * contentDate;
@property (nonatomic, retain) NSData * weather;
@property (nonatomic, retain) NSString * myMood;
@property (nonatomic, retain) NSString * diaryBody;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSData * myMoodImage;

@end
