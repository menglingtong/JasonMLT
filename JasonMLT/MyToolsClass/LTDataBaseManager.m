//
//  LTDataBaseManager.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTDataBaseManager.h"

#import "LTCategoryModel.h"

static LTDataBaseManager *LTDBM = nil;

@implementation LTDataBaseManager

// 数据库单例
+(LTDataBaseManager *)shareInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        LTDBM = [[LTDataBaseManager alloc] init];
        
    });
    
    return LTDBM;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.resultArr = [NSMutableArray array];
        
    }
    return self;
}

+(FMDatabase *)openDataBaseWithDBName:(NSString *)DBName
{
    
    // 获取本地document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [documentPath stringByAppendingPathComponent:DBName];
    
    // 创建数据库路径
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    [db open];
    
    return db;
    
}


// 系统第一次运行调用该方法
+(void)createDataBaseWithDBName:(NSString *)DBName
{
    
    // 获取本地document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [documentPath stringByAppendingPathComponent:DBName];
    
    NSLog(@"%@", documentPath);
    
    // 判断文件存在就不执行创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        
        // 创建数据库路径
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        
        // 判断打开数据库连接
        if ([db open]) {
            
            // 创建栏目表 - 栏目ID(主键) - 栏目名称 -
            NSString *createCategorySql = @"create table if not exists category(cateID integer primary key autoincrement, categoryTitle varchar(225) not null)";
            
            NSString *createCategoryDetailSql = @"create table if not exists categoryDetail(title varchar(225) primary key not null, parentTitle varchar(225) not null, api_url varchar(225) not null, is_Selected integer not null, indexPath integer not null, pic varchar(225) not null, color varchar(225) not null)";
            
            // 执行创建语句
            [db executeUpdate:createCategorySql];
            [db executeUpdate:createCategoryDetailSql];
            
            // 获取plist文件
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
            NSArray *array = [NSMutableArray arrayWithContentsOfFile:plistPath];
            
            // 解析plist文件
            for (NSDictionary *dic in array) {
                
                LTCategoryModel *categoryModel = [[LTCategoryModel alloc] initWithDic:dic];
                
                // 创建插入主栏目sql语句
                NSString *insertCategorySql = [NSString stringWithFormat:@"insert into category(categoryTitle) values('%@')", categoryModel.categoryTitle];
                
                // 执行语句
                [db executeUpdate:insertCategorySql];
                
                
                NSArray *categoryArray = [dic objectForKey:@"category"];
                
                for (NSDictionary *dicInArray in categoryArray) {
                    
                    if ([[dicInArray objectForKey:@"type"] isEqualToString:@"single"]) {
                        
                        
                        // 创建插入子栏目 sql语句
                        NSString *insertDetailCategorySql = [NSString stringWithFormat:@"insert into categoryDetail(title, parentTitle, api_url, is_Selected, indexPath, pic, color) values('%@', '%@', '%@', %d, %d, '%@', '%@')", [dicInArray objectForKey:@"title"], categoryModel.categoryTitle, [dicInArray objectForKey:@"api_url"], 1, 1000, [dicInArray objectForKey:@"pic"], [dicInArray objectForKey:@"color"]];
                        
                        [db executeUpdate:insertDetailCategorySql];
                    }
                    else
                    {
                        // 创建插入子栏目 sql语句
                        NSString *insertDetailCategorySql = [NSString stringWithFormat:@"insert into categoryDetail(title, parentTitle, api_url, is_Selected, indexPath, pic, color) values('%@', '%@', '%@', %d, %d, '%@', '%@')", [dicInArray objectForKey:@"title"], categoryModel.categoryTitle, @"子栏目", 0, 1000, [dicInArray objectForKey:@"pic"], [dicInArray objectForKey:@"color"]];
                        
                        [db executeUpdate:insertDetailCategorySql];
                        
                        NSArray *supCategory = [dicInArray objectForKey:@"subCategory"];
                        
                        for (NSDictionary *dict in supCategory) {
                            
                            NSString *insertSubCategorySql = [NSString stringWithFormat:@"insert into categoryDetail(title, parentTitle, api_url, is_Selected, indexPath, pic, color) values('%@', '%@', '%@', %d, %d, '%@', '%@')", [dict objectForKey:@"title"], [dicInArray objectForKey:@"title"], [dict objectForKey:@"api_url"], 0, 1000, @"图片", @"颜色"];
                            
                            [db executeUpdate:insertSubCategorySql];
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            [db close];
            
        }
        
    }

}


/**
 *  类方法的总结:
 *  1. 类方法可以调用类方法。
 *  2. 类方法不可以调用对象方法，但是类方法可以通过创建对象来访问对象方法。
 *  3. 类方法不可以使用实例变量。类方法可以使用self，因为self不是实例变量。
 *  4. 类方法作为消息，可以被发送到类或者对象里面去（实际上，就是可以通过类或者对象调用类方法的意思）。
 *
 *  self的规则
 *  1. 对象方法中的self, 是对象的首地址
 *  2. 类方法里的sel, 是class
 *
 */

+(NSMutableArray *)manageDataBaseWithOpreation:(LTDBOpreation)operation UpdateBody:(NSString *)updateBody TableName:(NSString *)tableName Condition:(NSString *)condition DBName:(NSString *)DBName
{
    
    // 获取数据库
    FMDatabase *db = [LTDataBaseManager openDataBaseWithDBName:DBName];
    
    
    NSString *sql = [NSString string];
    
    switch (operation) {
        case LTSelect:{
            
            // 判断是否有条件句
            if (condition == nil) {
                
                sql = [sql stringByAppendingFormat:@"select * from %@", tableName];
                
            }else{
                
                sql = [sql stringByAppendingFormat:@"select * from %@ where %@", tableName, condition];
                
            }
            
            
            [db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
                
                [[LTDataBaseManager shareInstance].resultArr addObject:resultsDictionary];
                
                return 0;
            }];
            
            [db close];
            
            return LTDBM.resultArr;
            
        }
            break;
            
        case LTUpdate:{
            
            // 判断是否有条件句
            if (condition == nil) {
                
                sql = [sql stringByAppendingFormat:@"update %@ set %@", tableName, updateBody];
                
            }else{
                
                sql = [sql stringByAppendingFormat:@"update %@ set %@ where %@", tableName, updateBody, condition];
                
            }
            
            [db executeUpdate:sql];
            
            // 关闭数据库
            [db close];
            
        }
            
            break;
            
        default:
            break;
    }
    
    
    return nil;
    
}


@end
