//
//  LTTopicEntranceModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicEntranceModel.h"

@implementation LTTopicEntranceModel

- (void)dealloc
{
    [_entranceDetailModelArray release];
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.entranceDetailModelArray = [[NSMutableArray alloc] init];
            
        LTEntranceDetailModel *model = [[LTEntranceDetailModel alloc] initWithDic:self.topic];
        
        [self.entranceDetailModelArray addObject:model];
        [model release];
        
        
    }
    
    return self;
}

@end
