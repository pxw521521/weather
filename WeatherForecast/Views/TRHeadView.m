//
//  TRHeadView.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHeadView.h"
#import "TRCityGroupTableViewController.h"
//左右边界
static CGFloat inset =20;
//label高
static CGFloat labelHeight=40;
//温度的label高
static CGFloat tempLabelHeight = 110;


@implementation TRHeadView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self ==[super initWithFrame:frame]) {
        CGRect frame = CGRectMake(0, inset, labelHeight, labelHeight);
        self.menuButton =[[UIButton alloc]initWithFrame:frame];
        [self.menuButton setImage:[UIImage imageNamed: @"IconHome"] forState:(UIControlStateNormal)];
        [self addSubview:self.menuButton];
        frame = CGRectMake(labelHeight, inset, self.bounds.size.width-self.menuButton.bounds.size.width, labelHeight);
        self.cityLable =[[UILabel alloc]initWithFrame:frame];
        
        self.cityLable.textColor = [UIColor whiteColor];
        self.cityLable.font =[UIFont systemFontOfSize:25];
        [self addSubview:self.cityLable];
        
        frame = CGRectMake(inset, self.bounds.size.height *0.5, labelHeight, labelHeight);
        self.iconView = [[UIImageView alloc]initWithFrame:frame];
        self.iconView.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.iconView];
        
        frame =CGRectMake(inset +labelHeight, self.bounds.size.height *0.5, 200, labelHeight);
        self.conditionsLabel =[[UILabel alloc]initWithFrame:frame];
        self.conditionsLabel.text = @"晴";
        self.conditionsLabel.textColor =[UIColor whiteColor];
        self.conditionsLabel.font = [UIFont systemFontOfSize:35];
        [self addSubview:self.conditionsLabel];
        
        frame =CGRectMake(inset, self.bounds.size.height *0.5 +labelHeight, 150, tempLabelHeight);
        self.temperatureLael = [[UILabel alloc]initWithFrame:frame];
        self.temperatureLael.text = @"10°";
        self.temperatureLael.font = [UIFont systemFontOfSize:100];
        self.temperatureLael.textColor =[UIColor whiteColor];
        [self addSubview:self.temperatureLael];
        
        frame =CGRectMake(inset, self.bounds.size.height *0.5 +labelHeight +110, self.bounds.size.width, labelHeight);
        self.hiloLabel = [[UILabel alloc]initWithFrame:frame];
        self.hiloLabel.text = @"-1°/10°";
        self.hiloLabel.font = [UIFont systemFontOfSize:35];
        self.hiloLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.hiloLabel];
        
        
    }
    
    return self;
}


-(void)changeData:(TRCurrentWeather *)currentData andLocation:(CLLocation *)location
{


    self.temperatureLael.text = [NSString stringWithFormat:@"%@°",currentData.temp_C];
    self.conditionsLabel.text = currentData.weatherDesc;
    self.hiloLabel.text = [NSString stringWithFormat:@"%@°/%@°",currentData.mintempC,currentData.maxtempC];
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:currentData.weatherIconUrl] placeholderImage:nil];

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
