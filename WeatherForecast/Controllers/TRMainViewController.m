//
//  TRMainViewController.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRMainViewController.h"
#import "TRHeadView.h"
#import "RESideMenu.h"
#import "TRDataManager.h"
#import "TRLocationManager.h"
#import "TRNetworkManager.h"
#import "TSMessage.h"
#import "TRHourly.h"
#import "TRDaily.h"
#import "TRCurrentWeather.h"
#import "UIImageView+WebCache.h"
#import <CoreLocation/CoreLocation.h>


@interface TRMainViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) TRHeadView *headView;
//保存用户位置
@property(nonatomic,strong) CLLocation *userLocation;
//每天的数据
@property(nonatomic,strong) NSArray *dailyArray;
//每小时的数据
@property(nonatomic,strong) NSArray *hourlyArray;
//当前数据
@property(nonatomic,strong) TRCurrentWeather *currentData;

@property(nonatomic,strong)CLGeocoder *geocoder;

@property(nonatomic,strong)NSString *cityName;
@end

@implementation TRMainViewController

-(TRHeadView *)headView
{
    if (!_headView) {
        _headView = [[TRHeadView alloc]initWithFrame:SCREEN_BOUNDS];
    }
    return _headView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取用户的位置并发送请求
    [self getLocationAndSendRequest];

    //监听通知
    [self listenNotification];
    
    //创建tableView
    [self createTableView];
    //创建头视图
    [self createHeadView];
    
    

}

-(void)listenNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenChangeCity:) name:@"DidCityChange" object:nil];
}
-(void)listenChangeCity:(NSNotification *)notification
{
    //获取传来的参
    NSString *cityName = notification.userInfo[@"CityName"];
    //NSLog(@"城市名字:%@",cityName);
    [self changeLocation:cityName];
    //self.cityName = cityName;
//    NSMutableString *ms =[[NSMutableString alloc]initWithString:cityName];
//        
//    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
//             
//        }
    
    
    [self createHeadView];
    
}
//改变定位
-(void)changeLocation:(NSString*)ms{
    
    self.geocoder =nil;
    self.geocoder =[[CLGeocoder alloc]init];
    
    [self.geocoder geocodeAddressString:ms completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
            
            CLPlacemark *placemark = [placemarks lastObject];
            self.userLocation =placemark.location;
        
   
            [self sendRequestToServer];
        
    }];
    
}

-(void)createHeadView
{
    
    self.tableView.tableHeaderView =self.headView;

        self.headView.cityLable.text = self.cityName;
//        self.headView.temperatureLael.text = [NSString stringWithFormat:@"%@°",self.currentData.temp_C];
//        self.headView.conditionsLabel.text = self.currentData.weatherDesc;
//        self.headView.hiloLabel.text = [NSString stringWithFormat:@"%@°/%@°",self.currentData.mintempC,self.currentData.maxtempC];
        [self.headView.iconView sd_setImageWithURL:[NSURL URLWithString:self.currentData.weatherIconUrl] placeholderImage:nil];
    
    
    [self.headView.menuButton addTarget:self action:@selector(clickButton) forControlEvents:(UIControlEventTouchUpInside)];
 
    
}




-(void)createTableView
{
    self.tableView =[UITableView new];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor =[UIColor clearColor];
    
    //需求:不想随着tableView的滚动而滚动
    
    //添加
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark -请求相关方法
-(void)getLocationAndSendRequest{
    
    [TRLocationManager getUserLocation:^(double lat, double lon) {
        CLLocation *location =[[CLLocation alloc]initWithLatitude:lat longitude:lon];
        //赋值
        self.userLocation = location;
 


        [self sendRequestToServer];
        

    }];

    }
-(void)sendRequestToServer
{
    
    NSLog(@"111");
    //设置TSMessage默认控制
    [TSMessage setDefaultViewController:self];
    //URL
    NSString *url = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=bd7878725dc0cb2d0756150256471",self.userLocation.coordinate.latitude,self.userLocation.coordinate.longitude];
    NSLog(@"%f,%f",self.userLocation.coordinate.latitude,self.userLocation.coordinate.longitude);
    //NetworkManager
    [TRNetworkManager sendGetRequestWithUrl:url parameters:nil succes:^(id responseObject) {
        NSLog(@"服务器返回的json数据:%@",responseObject);
        
        self.dailyArray =[TRDataManager getAllDailyData:responseObject];
        self.hourlyArray =[TRDataManager getAllHourlyData:responseObject];
        self.currentData = [TRDataManager getCurrentData:responseObject];
        
        [self.headView changeData:self.currentData andLocation:self.userLocation];
        CLGeocoder * geocoder =[[CLGeocoder alloc]init];
        [geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error) {
                   CLPlacemark *placemark = [placemarks lastObject];
            self.cityName = placemark.addressDictionary[@"City"];
            NSLog(@"%@",self.cityName);

                [self.tableView reloadData];
                [self createHeadView];
            }else
            {
                NSLog(@"%@",error.userInfo);
            }
         
        }];


        
//        [self.tableView reloadData];//刷新界面
    } failure:^(NSError *error) {
        NSLog(@"服务器请求失败:%@",error.userInfo);
        //显示
        [TSMessage showNotificationWithTitle:@"提示" subtitle:@"请稍后再试" type:(TSMessageNotificationTypeWarning)];
    }];

    
}


#pragma mark - 按钮触发方法
-(void)clickButton
{
  //显示左边的控制器
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ==0 ?  self.hourlyArray.count +1:self.dailyArray.count+1;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
        cell.backgroundColor =[UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        //设置cell不可以点击
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.textLabel.text =@"Hourly Forcast Info.";
            cell.imageView.image =nil;
            cell.detailTextLabel.text =nil;
        }else{
            TRHourly *hourly = self.hourlyArray[indexPath.row -1];
            cell.textLabel.text =hourly.time;
            cell.detailTextLabel.text = hourly.tempC;
            //图
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hourly.iconUrl] placeholderImage:nil];
        }
    }else{
        if (indexPath.row ==0) {
            cell.textLabel.text= @"Daily Forcast Info.";
            cell.imageView.image =nil;
        }else{
            TRDaily *daily = self.dailyArray[indexPath.row -1];
            cell.textLabel.text = daily.date;
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@ /%@",daily.maxtempC,daily.mintempC];
            //图
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:daily.iconUrl] placeholderImage:nil];
            
        }
        
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger rowCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return SCREEN_HEIGHT/rowCount;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
