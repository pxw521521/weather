//
//  AppDelegate.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "TRMainViewController.h"
#import "RESideMenu.h"
#import "TRLeftViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];
    
    //创建RESideMenu对象(指定内容/左边/右边)
    RESideMenu *sideViewConteoller =[[RESideMenu alloc]initWithContentViewController:[TRMainViewController new] leftMenuViewController:[TRLeftViewController new] rightMenuViewController:nil];
    sideViewConteoller.backgroundImage = [UIImage imageNamed:@"Stars"];
    //设置内容控制器的阴影颜色/半价/enable
    sideViewConteoller.contentViewShadowColor = [UIColor blackColor];
    sideViewConteoller.contentViewShadowRadius = 10;
    sideViewConteoller.contentViewShadowEnabled =YES;
    
    self.window.rootViewController =sideViewConteoller;
    
    
    self.window.backgroundColor =[UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
