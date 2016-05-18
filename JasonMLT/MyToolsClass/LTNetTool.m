//
//  LTNetTool.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTNetTool.h"
#import <AFNetworking.h>

@implementation LTNetTool

+(void)GetNetWithUrl:(NSString *)url body:(id)body header:(NSDictionary *)headers response:(LTResponseStyle)response success:(blockOfSuccess)success failure:(blockOfFail)fail
{
    // 1. 获取网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 请求头的设置
    if (headers) {
        
        for (NSString *key in headers.allKeys) {
            
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
            
        }
        
    }
    
    // 3. 设置返回数据的类型
    switch (response) {
        case LTJSON:
            
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            break;
            
        case LTXML:
            
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            
            break;
            
        case LTDATA:
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            break;
            
        default:
            break;
    }
    
    // 4. 设置响应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 5. iOS9 -- UTF-8 转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6. 发送请求
    [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        NSLog(@"%@", error);
        
    }];
    
}


+(void)PostNetWithUrl:(NSString *)url body:(id)body bodyStyle:(LTRequestStyle)bodyStyle header:(NSDictionary *)headers response:(LTResponseStyle)response success:(blockOfSuccess)success failure:(blockOfFail)fail
{
    
    // 1. 获取网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 设置body数据类型
    switch (bodyStyle) {
        case LTBodyJSON:
            
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            
            break;
            
        case LTBodyString:
            
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                
                return parameters;
                
            }];
            
            break;
            
        default:
            break;
    }
    
    // 3. 请求头的设置
    if (headers) {
        
        for (NSString *key in headers.allKeys) {
            
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
            
        }
        
    }
    
    // 4. 设置返回数据的类型
    switch (response) {
        case LTJSON:
            
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            break;
            
        case LTXML:
            
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            
            break;
            
        case LTDATA:
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            break;
            
        default:
            break;
    }
    
    // 5. 设置响应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 6. iOS9 -- UTF-8 转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 7. 发送请求
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        NSLog(@"%@", error);
        
    }];
    
    
    
    
    
}















@end
