//
//  DriftComputingTools.m
//  DayNote
//
//  Created by boluchuling on 15/10/22.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DriftComputingTools.h"

static DriftComputingTools *tools = nil;
@implementation DriftComputingTools

+ (instancetype)shareDriftComputing {
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[DriftComputingTools alloc] init];
        });
    }
    return tools;
}


// 计算目的地坐标
- (CLLocationCoordinate2D)calculateEstimatedPosition{

    CLLocationCoordinate2D ss;
    ss.latitude = ((double)((arc4random()%(80 - 24 + 1)+24)*111111))/200000.00;
    ss.longitude = ((double)((arc4random()%(115 - 80 + 1)+80)*111111))/110000.00;
//    NSLog(@"%lf", ss.longitude);

    return ss;
} 



@end
