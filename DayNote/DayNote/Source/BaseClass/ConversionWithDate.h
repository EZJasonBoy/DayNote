//
//  ConversionWithDate.h
//  DayNote
//
//  Created by lanou3g on 15/10/17.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GZWDateFormatType) {
    // 日期组合格式
    GZWDateFormatTypePoint,
    GZWDateFormatTypeConnector,
    GZWDateFormatTypeWord,
    GZWDateFormatTypeTime,
    GZWDateFormatTypeDateTime,
    GZWDateFormatTypeHoursMinute,
    GZWDateFormatTypeMinuteSeconds,
    
    // 单个年,月,日
    GZWDateFormatTypeYear,
    GZWDateFormatTypeMouth,
    GZWDateFormatTypeDay,
    
    // 单个时,分,秒
    GZWDateFormatTypeHours,
    GZWDateFormatTypeMinute,
    GZWDateFormatTypeSeconds
};

@interface ConversionWithDate : NSObject

+ (instancetype)shareDateConversion;

- (NSDate *)getDateWithString:(NSString *)aString;
- (NSString *)getStringWithDate:(NSDate *)aDate type:(GZWDateFormatType)type;

@end
