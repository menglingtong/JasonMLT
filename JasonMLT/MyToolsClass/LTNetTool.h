//
//  LTNetTool.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^blockOfSuccess)(id result);
typedef void(^blockOfFail)(NSError *error);

typedef NS_ENUM(NSUInteger, LTResponseStyle) {
    LTJSON,
    LTDATA,
    LTXML,
};

typedef NS_ENUM(NSUInteger, LTRequestStyle) {
    LTBodyJSON,
    LTBodyString,
};


@interface LTNetTool : NSObject

+(void)GetNetWithUrl:(NSString *)url
                body:(id)body
              header:(NSDictionary *)headers
            response:(LTResponseStyle)response
             success:(blockOfSuccess)success
             failure:(blockOfFail)fail;


+(void)PostNetWithUrl:(NSString *)url
                body:(id)body
           bodyStyle:(LTRequestStyle)bodyStyle
              header:(NSDictionary *)headers
            response:(LTResponseStyle)response
             success:(blockOfSuccess)success
             failure:(blockOfFail)fail;



@end
