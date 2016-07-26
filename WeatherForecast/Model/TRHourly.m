//
//  TRHourly.m
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHourly.h"

@implementation TRHourly


+(TRHourly *)parseHourlyJson:(NSDictionary *)dic
{
    
    return [[self alloc] parseHourlyJson:dic];
}

-(TRHourly *)parseHourlyJson:(NSDictionary *)dic{
    
    
    self.tempC = dic[@"tempC"];
    int x =[dic[@"time"] intValue]/100;
    self.time =[NSString stringWithFormat:@"%d:00",x];
    self.iconUrl =dic[@"weatherIconUrl"][0][@"value"];
    
    return self;
}
@end
