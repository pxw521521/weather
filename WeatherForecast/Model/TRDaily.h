//
//  TRDaily.h
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDaily : NSObject

//日期
@property(nonatomic,strong)NSString *date;
//最高温
@property(nonatomic,strong)NSString *maxtempC;
//最低温
@property(nonatomic,strong)NSString *mintempC;
//图片
@property(nonatomic,strong)NSString *iconUrl;

//给定每天字典，返回TRDaily
+(TRDaily *)parseDailyJson:(NSDictionary *)dic;

@end
