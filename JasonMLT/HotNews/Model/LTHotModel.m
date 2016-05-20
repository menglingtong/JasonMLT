//
//  LTHotModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTHotModel.h"

@implementation LTHotModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    
    self = [super initWithDic:dic];
    
    if (self) {
        
        LTHotStyleModel *model = [[LTHotStyleModel alloc] initWithDic:self.style];
        
        [self.styleArray addObject:model];
        [model release];
        
    }
    
    
    return self;
}

@end
