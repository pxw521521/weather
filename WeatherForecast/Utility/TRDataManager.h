//
//  TRDataManager.h
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRCurrentWeather.h"

@interface TRDataManager : NSObject
//返回所有的城市组数组(TRCityGroup)
+(NSArray *)getAllCityGroup;

//给定,返回所有每天数组(TRDaily)
+(NSArray* )getAllDailyData:(id)responseObject;


//返回每小时数据(TRHourly)
+(NSArray *)getAllHourlyData:(id)responseObject;

//返回当前数据
+(TRCurrentWeather *)getCurrentData:(id)responseObject;

@end
