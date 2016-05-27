//
//  LTTopicEntranceListModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/26.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicEntranceListModel.h"

#import "LTTopicEntranceMediaModel.h"

@implementation LTTopicEntranceListModel

- (void)dealloc
{
    [_mediaModelArray release];
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.mediaModelArray = [[NSMutableArray alloc] init];
        
        LTTopicEntranceMediaModel *model = [[LTTopicEntranceMediaModel alloc] initWithDic:[self.media firstObject]];
        
        [self.mediaModelArray addObject:model];
        
        [model release];
        
    }
    
    return self;
}

@end
