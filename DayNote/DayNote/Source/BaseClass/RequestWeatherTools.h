//
//  RequestWeatherTools.h
//  DayNote
//
//  Created by boluchuling on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^weather)(NSDictionary *dict);
@interface RequestWeatherTools : NSObject

+ (instancetype)shareRequestWeather;

/*!
 *  @brief  根据城市获取天气
 *
 *  @param aName    城市名称
 *  @param aWeather Block返回天气数据
 *
 *  @since 1.0
 */
- (void)getWeatherDetailsWithCity:(NSString *)aName Weather:(weather)aWeather;

@end
