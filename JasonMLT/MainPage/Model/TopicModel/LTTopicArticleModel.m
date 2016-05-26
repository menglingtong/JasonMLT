//
//  LTTopicArticleModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicArticleModel.h"

@implementation LTTopicArticleModel

- (void)dealloc
{
    [_articleDetailModelArray release];
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.articleDetailModelArray = [[NSMutableArray alloc] init];
        
        LTArticleDetailModel *model = [[LTArticleDetailModel alloc] initWithDic:self.article];
        
        [self.articleDetailModelArray addObject:model];
        
        [model release];
        
    }
    
    return self;
}

@end
