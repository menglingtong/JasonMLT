//
//  LTPlayScrollModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTPlayScrollModel.h"

@implementation LTPlayScrollModel


- (void)dealloc
{
    
    [_webModelArray release];
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.webModelArray = [[NSMutableArray alloc] init];
        
        LTScrollWebModel *model = [[LTScrollWebModel alloc] initWithDic:self.web];
        
        [self.webModelArray  addObject:model];
        [model release];
        
    }
    
    return self;
}

@end



