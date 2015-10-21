//
//  RequestWeatherTools.h
//  DayNote
//
//  Created by lanou3g on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^weather)(NSDictionary *dict);
@interface RequestWeatherTools : NSObject

+ (instancetype)shareRequestWeather;
- (void)getWeatherDetailsWithCity:(NSString *)aName Weather:(weather)aWeather;

@end
