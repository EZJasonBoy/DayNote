//
//  RequestWeatherTools.m
//  DayNote
//
//  Created by lanou3g on 15/10/19.
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

- (void)getWeatherDetailsWithCity:(NSString *)aName Weather:(weather)aWeather{
    
    NSString *apiStr = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?city=%@&key=a5b479f2b93944458148216010ead6cf", aName];
    NSURL *url = [NSURL URLWithString:apiStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"%@", connectionError.localizedDescription);
            
        } else {
            NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableDictionary *passDict = [NSMutableDictionary dictionary];
            for (NSString *dict in arr[@"HeWeather data service 3.0"][0][@"now"][@"cond"]) {
                [passDict setObject:arr[@"HeWeather data service 3.0"][0][@"now"][@"cond"][dict] forKey:dict];
            }
            NSLog(@"%@", passDict);
            aWeather(passDict);
        }
    }];
}

@end
