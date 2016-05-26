//
//  LTTopicDailyModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicDailyModel.h"

@implementation LTTopicDailyModel

- (void)dealloc
{
    [_topicListArray release];
    
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.topicListArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in self.topic_list) {
            
            LTTopicListModel *model = [[LTTopicListModel alloc] initWithDic:dict];
            
            [self.topicListArray addObject:model];
            [model release];
            
        }
        
    }
    
    return self;
}

@end
