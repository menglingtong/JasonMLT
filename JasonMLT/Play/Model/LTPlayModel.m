//
//  LTPlayModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTPlayModel.h"

@implementation LTPlayModel

-(void)dealloc
{
    [_articleModel release];
    [_picModel release];
    
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.articleModelArray = [[NSMutableArray alloc] init];
        
        self.picModelArray = [[NSMutableArray alloc] init];
        
        self.articleModel = [[LTArticleModel alloc] initWithDic:self.article];
        
        [self.articleModelArray addObject:_articleModel];
        [_articleModel release];
        
        self.picModel = [[LTPicModel alloc] initWithDic:self.pic];
        
        [self.picModelArray addObject:_picModel];
        [_picModel release];
        
    }
    
    return self;
}


@end


