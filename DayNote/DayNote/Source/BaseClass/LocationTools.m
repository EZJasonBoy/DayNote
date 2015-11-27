//
//  LocationTools.m
//  DayNote
//
//  Created by boluchuling on 15/10/22.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "LocationTools.h"

static LocationTools *tools = nil;
@implementation LocationTools 

+ (instancetype)shareLocation {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[LocationTools alloc] init];
    });
    return tools;
}
- (BOOL)detectWhetherToSupportLocalization {
    if (![CLLocationManager locationServicesEnabled]) {
        return NO;
    }
    return YES;
}

- (void)requestAuthorization {
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.manager requestWhenInUseAuthorization];
    }
}

- (void)initializePositioning {
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"支持定位");
    }else {
        NSLog(@"不支持定位");
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self requestAuthorization];
    });
    
    self.geocoder = [[CLGeocoder alloc] init];
    self.manager = [[CLLocationManager alloc] init];
    
    self.manager.delegate = self;
    
    self.manager.distanceFilter = 1000.0f;
    
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    
}

- (void)locationStart {
    [self.manager startUpdatingLocation];
}

- (void)getCoordinateWithCityName:(NSString *)city {
    [self.geocoder geocodeAddressString:city completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark *placemark = [placemarks lastObject];
            self.location = placemark.location.coordinate;
        }else {
        }
    }];
}

- (void)getCityNameWithCoordinate:(CLLocationCoordinate2D)location city:(City)cityName {
    NSLog(@"%f", location.latitude);
    CLLocation *locations = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [self.geocoder reverseGeocodeLocation:locations completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            cityName(nil);
            return ;
        } 
        CLPlacemark *placemark = [placemarks lastObject];
        cityName(placemark.addressDictionary[@"City"]);
    }];

}

#pragma mark - delegate
// 发生一次定位后,走的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
   
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingHeading];
    self.location = location.coordinate;
    NSLog(@"%f", location.coordinate.latitude);
    
    [self getCityNameWithCoordinate:location.coordinate city:^(NSString *cityName) {
        self.localCity = cityName;
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:cityName forKey:@"local"];
        if (cityName == nil) {// 如果解析为空
            cityName = @"北京市";
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObject:cityName forKey:@"city"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"local" object:nil userInfo:dict];
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"fails");
}
@end
