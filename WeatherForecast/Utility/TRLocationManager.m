//
//  TRLocationManager.m
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLocationManager.h"
#import <UIKit/UIKit.h>
@interface TRLocationManager()<CLLocationManagerDelegate>

@property(nonatomic,strong) CLLocationManager *manager;
@property(nonatomic,copy) void(^saveLocationBlock)(double lat,double lon);

@end

@implementation TRLocationManager
//懒加载的方式初始化
//单例:一个类的唯一一个实例对象
+(id)sharedLocationManager{
    
    static TRLocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[TRLocationManager alloc]init];
    }
    return locationManager;
    
}
//重写init方法初始化manager对象/征求用户同意
-(instancetype)init
{
    if (self = [super init]) {
        self.manager = [CLLocationManager new];
       //判断ios版本
        if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0) {
            [self.manager requestWhenInUseAuthorization];
        }
        self.manager.delegate = self;
    
    
    
    }
    return self;
}
+(void)getUserLocation:(saveLocationBlock)locationBlock
{
    
    TRLocationManager *locationManager = [TRLocationManager sharedLocationManager];
    [locationManager getUserLocations:locationBlock];
    
    
}

-(void)getUserLocations:(saveLocationBlock)locationBlock
{
    //用户没有同意/没有开启定位功能
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"");
        //告诉用户没有开启定位
        return;
    }
    //同意/开启 -> 开始定位
    _saveLocationBlock =[locationBlock copy];
    //设置精度
    self.manager.distanceFilter = 500;
    
    //开始定位
    [self.manager startUpdatingLocation];
    
    
    
    
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location =[locations firstObject];
    
    //block传参
    _saveLocationBlock(location.coordinate.latitude,location.coordinate.longitude);
    
    
}


@end
