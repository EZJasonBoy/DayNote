//
//  GetDataTools.h
//  DayNote
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;
@interface GetDataTools : NSObject

+ (instancetype)shareGetDataTool;

- (BOOL)addDiaryForContentDate:(NSDate *)contentDate Create:(NSDate *)createDate Details:(NSString *)diaryBody Weather:(NSString *)weather WeatherImage:(NSString *)weatherImage;

- (BOOL)updateDataWithCreateDate:(NSDate *)aDate ForDetails:(NSString *)diaryBody;

- (NSArray *)selectAllData;

- (NSArray *)descendingDataArray;

- (NSArray *)selectDataWithIndex:(NSInteger)index;

- (BOOL)deleteDataWithDate:(NSDate *)aDate;

@end
