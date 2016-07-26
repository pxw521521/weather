//
//  TRLeftViewController.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLeftViewController.h"
#import "PrefixHeader.pch"
#import "TRCityGroupTableViewController.h"
@interface TRLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

CGFloat cellHeight = 50;

@implementation TRLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建TableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-cellHeight*2)/2, SCREEN_WIDTH, cellHeight*2)];
    tableView.delegate = self;
    tableView.dataSource =self;
    tableView.backgroundColor =[UIColor clearColor];
    tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableView];
}

#pragma mark - 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSArray *titles = @[@"切换城市",@"其它"];
    NSArray *images = @[@"IconSettings",@"IconProfile"];
    cell.textLabel.text =titles[indexPath.row];
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView =[UIView new];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    cell.backgroundColor =[UIColor clearColor];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
        //创建城市视图控制器对象
        TRCityGroupTableViewController *cityGroupViewController =[[TRCityGroupTableViewController alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:cityGroupViewController];
        
        //显示
        [self presentViewController:navigationController animated:YES completion:nil];
    
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
