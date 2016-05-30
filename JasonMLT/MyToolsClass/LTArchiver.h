//
//  LTArchiver.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/29.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTArchiver : NSObject

// 归档的工具方法
+(void)archiverObject:(id)object
                ByKey:(NSString *)key
             WithPath:(NSString *)path;

// 反归档的方法
+(id)unarchiverObjectByKey:(NSString *)key
                  WithPath:(NSString *)path;

@end
