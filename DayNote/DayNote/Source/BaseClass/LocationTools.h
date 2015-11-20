//
//  LocationTools.h
//  DayNote
//
//  Created by boluchuling on 15/10/22.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^City)(NSString *cityName);

@interface LocationTools : NSObject <CLLocationManagerDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString *localCity;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLGeocoder *geocoder;

+ (instancetype)shareLocation;
- (void)initializePositioning;

- (void)locationStart;
- (void)getCoordinateWithCityName:(NSString *)city ;
- (void)getCityNameWithCoordinate:(CLLocationCoordinate2D)location city:(City)cityName;

@end
