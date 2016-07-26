//
//  TRDaily.m
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRDaily.h"

@implementation TRDaily


+(TRDaily *)parseDailyJson:(NSDictionary *)dic
{
    return [[self alloc] parseDailyJson:dic];
    
}

-(TRDaily *)parseDailyJson:(NSDictionary *)dic
{
    self.date =dic[@"date"];
    self.maxtempC =dic[@"maxtempC"];
    self.mintempC =dic[@"mintempC"];
    self.iconUrl =dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
    
    
    return self;
    
}
@end
