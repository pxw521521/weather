//
//  TRLocationManager.h
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^saveLocationBlock)(double lat,double lon);

@interface TRLocationManager : NSObject

+(void)getUserLocation:(saveLocationBlock)locationBlock;



@end
