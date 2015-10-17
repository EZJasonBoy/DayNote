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

- (BOOL)addDiaryWithModel:(NSDate *)contentDate create:(NSDate *)createDate details:(NSString *)diaryBody;
- (NSArray *)selectAllData;
- (NSArray *)descendingDataArray;
- (BOOL)deleteDataWithDate:(NSDate *)aDate;
@end
