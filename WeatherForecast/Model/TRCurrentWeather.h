//
//  TRCurrentWeather.h
//  WeatherForecast
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCurrentWeather : NSObject

@property(nonatomic,strong)NSString *maxtempC;
@property(nonatomic,strong)NSString *mintempC;
@property(nonatomic,strong)NSString *temp_C;
@property(nonatomic,strong)NSString *weatherDesc;
@property(nonatomic,strong)NSString *weatherIconUrl;


+(TRCurrentWeather *)parsenCurrentJson:(NSDictionary *)dic;
@end
