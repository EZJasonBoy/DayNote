//
//  ParsIngDataTools.m
//  DayNote
//
//  Created by lanou3g on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "ParsingDataTools.h"

static ParsingDataTools *tools = nil;

@implementation ParsingDataTools

+ (instancetype)shareParsingData {
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[ParsingDataTools alloc] init];
        });
    }
    return tools;
}

- (NSArray *)getJsonWithData:(NSData *)aData {
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }else {
        return array;
    }
}

#warning xml 
- (NSArray *)getXMLWithData:(NSData *)aData {
    
    return [NSArray array];
}

@end
