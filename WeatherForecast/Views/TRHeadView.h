//
//  TRHeadView.h
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TRCurrentWeather.h"
@interface TRHeadView : UIView

//button
@property(nonatomic,strong) UIButton *menuButton;
//CityName
@property(nonatomic,strong)UILabel *cityLable;
//imageView
@property(nonatomic,strong)UIImageView *iconView;
//currentWeather
@property(nonatomic,strong)UILabel *conditionsLabel;
//todaytemperature
@property(nonatomic,strong)UILabel *temperatureLael;
//maxTemperature/minTemperature
@property(nonatomic,strong)UILabel *hiloLabel;

-(void)changeData:(TRCurrentWeather *)currentData andLocation:(CLLocation *)location;

@end
