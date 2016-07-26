//
//  TRNetworkManager.m
//  Demo1-AFNetworking
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRNetworkManager.h"
#import "AFNetworking.h"
@implementation TRNetworkManager


+(void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic succes:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //服务器成功返回,responseObject回传控制器
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //服务器失败返回,error传回控制器
        failure(error);
    }];
    
}
@end
