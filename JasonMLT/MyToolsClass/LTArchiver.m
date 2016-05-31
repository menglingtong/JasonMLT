//
//  LTArchiver.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/29.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTArchiver.h"

@implementation LTArchiver

/**
 *  归档工具
 *
 *  @param object 被存储对象
 *  @param key    反归档所使用的唯一标识
 *  @param path   存储路径
 */
+(void)archiverObject:(id)object ByKey:(NSString *)key WithPath:(NSString *)path
{
    // 初始化存储对象信息的data
    NSMutableData *data = [NSMutableData data];
    
    // 创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 开始归档
    [archiver encodeObject:object forKey:key];
    
    // 结束归档
    [archiver finishEncoding];
    
    // 写入本地文件
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *destPath = [docPath stringByAppendingPathComponent:path];
    
    [data writeToFile:destPath atomically:YES];
    
}

/**
 *  反归档工具
 *
 *  @param key  归档时所使用的key
 *  @param path 存储路径
 *
 *  @return 返回存储进去的obj
 */
+(id)unarchiverObjectByKey:(NSString *)key WithPath:(NSString *)path
{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *destPath = [docPath stringByAppendingPathComponent:path];
    
    NSData *data = [NSData dataWithContentsOfFile:destPath];
    
    // 创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    // 接受反归档得到的对象
    id object = [unarchiver decodeObjectForKey:key];
    
    return object;
    
}


@end
