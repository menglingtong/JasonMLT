//
//  LTDataBaseManager.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

typedef NS_ENUM(NSUInteger, LTDBOpreation) {
    LTSelect,
    LTUpdate,
    LTInsert,
};

@interface LTDataBaseManager : NSObject

+(LTDataBaseManager *)shareInstance;

/** 搜索结果字典 */
@property (nonatomic, retain) NSMutableArray *resultArr;

// 打开指定路径的数据库
+ (FMDatabase *)openDataBaseWithDBName:(NSString *)DBName;

// 创建数据库
+ (void)createDataBaseWithDBName:(NSString *)DBName;

// 创建表
//+ (void)createTable:(NSString *)tableName category:(NSArray *)categoryArr;

// 数据库操作函数
+ (NSMutableArray *) manageDataBaseWithOpreation:(LTDBOpreation)operation UpdateBody:(NSString *)updateBody TableName:(NSString *)tableName Condition:(NSString *)condition DBName:(NSString *)DBName;

@end
