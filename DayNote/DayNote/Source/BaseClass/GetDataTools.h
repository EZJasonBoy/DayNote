//
//  GetDataTools.h
//  DayNote
//
//  Created by boluchuling on 15/10/16.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DayNote;
@interface GetDataTools : NSObject

+ (instancetype)shareGetDataTool;

- (BOOL)addDiaryForContentDate:(NSDate *)contentDate Create:(NSDate *)createDate Details:(NSString *)diaryBody Weather:(NSString *)weather WeatherImage:(NSString *)weatherImage Mood:(NSString *)mood MoodImage:(NSInteger)moodImage  DiaryImage:(NSString *)diaryImage userName:(NSString *)aName;

- (BOOL)updateALLDataUserNameWithDict:(NSDictionary *)aDict;
- (BOOL)updateDataWithCreateDate:(NSDate *)aDate ForDetails:(NSString *)diaryBody ForImage:(NSString *)diaryImage;

- (DayNote *)selectDataWithDate:(NSDate *)aDate;

- (CGFloat)selectDataCountWithMood:(NSString *)aMood;
- (NSArray *)selectDataWithMood:(NSString *)aMood;

- (NSArray *)selectDataWithIndex:(NSInteger)index;
//- (NSArray *)selectAllData;

- (NSArray *)selectDataWithUserName:(NSString *)aName;

- (NSArray *)descendingDataArray;

- (BOOL)deleteDataWithDate:(NSDate *)aDate;
- (BOOL)deleteDataWithUserName:(NSString *)aName;

@end
