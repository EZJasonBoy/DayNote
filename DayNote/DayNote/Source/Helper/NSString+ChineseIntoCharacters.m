//
//  NSString+ChineseIntoCharacters.m
//  DayNote
//
//  Created by boluchuling on 15/10/24.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "NSString+ChineseIntoCharacters.h"

@implementation NSString (ChineseIntoCharacters)

+ (BOOL)isChineseForString:(NSString *)aString {
    for (int i = 0; i < [aString length]; i++) {
        int a = [aString characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

@end
