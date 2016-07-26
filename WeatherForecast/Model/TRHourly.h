//
//  TRHourly.h
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRHourly : NSObject

@property(nonatomic,strong)NSString *iconUrl;
@property(nonatomic,strong)NSString *tempC;
@property(nonatomic,strong)NSString *time;

+ (TRHourly *)parseHourlyJson:(NSDictionary *)dic;

@end
