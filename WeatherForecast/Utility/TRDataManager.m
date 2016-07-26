//
//  TRDataManager.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRDataManager.h"
#import "TRCityGroup.h"
#import "TRDaily.h"
#import "TRHourly.h"


@implementation TRDataManager

//单例 一个类只有一个对象
//static TRDataManager *_dataManager =nil;
//+(TRDataManager *)sharedDataManager{
//    
//    if (!_dataManager) {
//        _dataManager = [TRDataManager new];
//    }
//    return _dataManager;
//    
//}
static NSArray *_cityGroupArray =nil;
+(NSArray *)getAllCityGroup
{
    
    if (!_cityGroupArray) {
        _cityGroupArray = [[self alloc] getCityGroups];
    }
    return _cityGroupArray;
    
}

-(NSArray *)getCityGroups
{
    NSString *plistPath =[[NSBundle mainBundle] pathForResource:@"cityGroups" ofType:@"plist"];
    NSArray *cityGroups = [NSArray arrayWithContentsOfFile:plistPath];
    //所有字典对象转换成模型对象
    NSMutableArray *mutableArray =[NSMutableArray array];
    for (NSDictionary *dic in cityGroups) {
        //声明一个空的TRCityGroup对象
        TRCityGroup *cityGroup =[TRCityGroup new];
        //KVC绑定模型对象属性和字典KEY的关系
        [cityGroup setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:cityGroup];
    }
    return [mutableArray copy];
}

+(NSArray*)getAllDailyData:(id)responseObject
{
    //获取到weather对应的value
     NSArray *weatherArrary = responseObject[@"data"][@"weather"];
    //循环解析数据
    NSMutableArray *mutableArray =[NSMutableArray array];
    for (NSDictionary *dic in weatherArrary) {
        TRDaily *daily = [TRDaily parseDailyJson:dic];
        [mutableArray addObject:daily];
        
    }
    return [mutableArray copy];
    
}

+(NSArray *)getAllHourlyData:(id)responseObject
{
    NSArray *weatherArray =responseObject[@"data"][@"weather"][0][@"hourly"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in weatherArray) {
        TRHourly *hourly = [TRHourly parseHourlyJson:dic];
        [mutableArray addObject:hourly];
    }
    return [mutableArray copy];
    
}

+(TRCurrentWeather *)getCurrentData:(id)responseObject
{
    NSDictionary *dic = responseObject[@"data"];
    TRCurrentWeather *currentData =[TRCurrentWeather parsenCurrentJson:dic];
    
    return currentData;
    
}

@end
