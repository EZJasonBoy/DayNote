//
//  RequestWeatherTools.m
//  DayNote
//
//  Created by boluchuling on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "RequestWeatherTools.h"

static RequestWeatherTools *tools = nil;
@implementation RequestWeatherTools

+ (instancetype)shareRequestWeather {
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[RequestWeatherTools alloc] init];
        });
    }
    return tools;
}
// 根据城市获取天气
- (void)getWeatherDetailsWithCity:(NSString *)aName Weather:(weather)aWeather{

    NSString *apiStr = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?city=%@&key=a5b479f2b93944458148216010ead6cf", aName];
    ;
    if ([NSString isChineseForString:apiStr]) {
        apiStr = [apiStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURL *url = [NSURL URLWithString:apiStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"天气请求失败😢" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissWithClickedButtonIndex:0 animated:YES];
            });
        } else {
            NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableDictionary *passDict = [NSMutableDictionary dictionary];
            for (NSString *dict in arr[@"HeWeather data service 3.0"][0][@"now"][@"cond"]) {
                [passDict setObject:arr[@"HeWeather data service 3.0"][0][@"now"][@"cond"][dict] forKey:dict];
            }
            aWeather(passDict);
        }
    }];
}

@end
