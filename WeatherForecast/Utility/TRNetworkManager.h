//
//  TRNetworkManager.h
//  Demo1-AFNetworking
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRNetworkManager : NSObject

typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);



+(void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic succes:(successBlock)success failure:(failureBlock)failure;


//
//
@end
