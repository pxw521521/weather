//
//  TRCurrentWeather.m
//  WeatherForecast
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRCurrentWeather.h"

@implementation TRCurrentWeather

+(TRCurrentWeather *)parsenCurrentJson:(NSDictionary *)dic
{
    
    return [[self alloc] parsenCurrentJson:dic];
}

-(TRCurrentWeather *)parsenCurrentJson:(NSDictionary *)dic
{
    
    self.temp_C = dic[@"current_condition"][0][@"temp_C"];
    self.weatherDesc = dic[@"current_condition"][0][@"weatherDesc"][0][@"value"];
    self.weatherIconUrl =dic[@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
    self.maxtempC = dic[@"weather"][0][@"maxtempC"];
    self.mintempC =dic[@"weather"][0][@"mintempC"];
    
    
    return self;
    
}
@end
