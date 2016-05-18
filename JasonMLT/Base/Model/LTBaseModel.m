//
//  LTBaseModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/11.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@implementation LTBaseModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
}

/**
 *  容错方法
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setNilValueForKey:(NSString *)key
{
    
}

@end
