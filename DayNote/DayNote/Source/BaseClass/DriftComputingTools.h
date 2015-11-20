//
//  DriftComputingTools.h
//  DayNote
//
//  Created by boluchuling on 15/10/22.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^City)(NSString *cityName);
@interface DriftComputingTools : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D initialPosition;
@property (nonatomic, assign) CLLocationCoordinate2D TransitPosition;
@property (nonatomic, strong) NSString *targetCity;
@property (nonatomic, assign) double distance;
@property (nonatomic, strong) NSDate *creationTime;

+ (instancetype)shareDriftComputing;

//- (void)initOurPositionWith:(CLLocationCoordinate2D)currentPosition;
- (CLLocationCoordinate2D)calculateEstimatedPosition;
//- (void)calculateEstimatedLocationToCity:(City)cityName;

@end
