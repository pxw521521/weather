//
//  TRCityGroupTableViewController.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRCityGroupTableViewController.h"
#import "TRDataManager.h"
#import "TRCityGroup.h"

@interface TRCityGroupTableViewController ()

@property(nonatomic,strong)NSArray *cityGroupArray;

@end

@implementation TRCityGroupTableViewController

-(NSArray *)cityGroupArray
{
    if (!_cityGroupArray) {
        _cityGroupArray = [TRDataManager getAllCityGroup];
    }
    return _cityGroupArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"城市列表";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem =backItem;
}

-(void)clickBackItem
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    TRCityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    
        
        
    }
    
        TRCityGroup *cityGroup =self.cityGroupArray[indexPath.section];
        
        cell.textLabel.text =cityGroup.cities[indexPath.row];
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TRCityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.title;
}

//返回tableViewIndex数组
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    //方式一
//    NSMutableArray *titleMutableArray =[NSMutableArray array];
//    for (TRCityGroup *cityGroup in self.cityGroupArray) {
//        [titleMutableArray addObject:cityGroup.title];
//    }
//   
//    return [titleMutableArray copy];
    
    //方式二
    return [self.cityGroupArray valueForKeyPath:@"title"];
}

//选中城市
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRCityGroup *cityGroup =self.cityGroupArray[indexPath.section];
    //发送通知,包含参数(选择的城市名称)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCityChange" object:self userInfo:@{@"CityName":cityGroup.cities[indexPath.row]}];
    
    

    //收回控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
