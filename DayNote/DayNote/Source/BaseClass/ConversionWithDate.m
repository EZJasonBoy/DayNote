//
//  ConversionWithDate.m
//  DayNote
//
//  Created by lanou3g on 15/10/17.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "ConversionWithDate.h"



static ConversionWithDate *tools = nil;
@implementation ConversionWithDate

+ (instancetype)shareDateConversion {
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[ConversionWithDate alloc] init];
        });
    }
    return tools;
}


- (NSDate *)getDateWithString:(NSString *)aString {
    
    return [NSDate date];
}

- (NSString *)getStringWithDate:(NSDate *)aDate type:(GZWDateFormatType)aType {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    switch (aType) {
        
        case GZWDateFormatTypeWord:
            [dateFormat setDateFormat:@"YYYY年MM月dd日"];
            break;
        case GZWDateFormatTypePoint:
            [dateFormat setDateFormat:@"YYYY.MM.dd"];
            break;
        case GZWDateFormatTypeConnector:
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            break;
        case GZWDateFormatTypeTime:
            [dateFormat setDateFormat:@"hh:mm:ss"];
            break;
        case GZWDateFormatTypeDateTime:
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            break;
        default:
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            break;
            
    }
    
    return [dateFormat stringFromDate:aDate];
}

@end
