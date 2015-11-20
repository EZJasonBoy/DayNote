//
//  ConversionWithDate.h
//  DayNote
//
//  Created by boluchuling on 15/10/17.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GZWDateFormatType) {
    // 日期组合格式
    GZWDateFormatTypePoint,// xxx.xxx.xxx
    GZWDateFormatTypeConnector, // xxx-xxx-xxx
    GZWDateFormatTypeWord, // xxx年xxx月xxx日
    GZWDateFormatTypeTime, // xx/xx/xx
    GZWDateFormatTypeDateTime, // xxx-xxx-xxx_xx/xx/xx
    GZWDateFormatTypeHoursMinute, // xx/xx
    GZWDateFormatTypeMinuteSeconds, // xx/xx
    
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
