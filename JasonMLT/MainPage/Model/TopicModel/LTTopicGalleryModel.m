//
//  LTTopicGalleryModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicGalleryModel.h"

#import "LTGalleryDetailModel.h"

@implementation LTTopicGalleryModel

- (void)dealloc
{
    [_articleModelArray release];
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.articleModelArray = [[NSMutableArray alloc] init];
        
        LTGalleryDetailModel *model = [[LTGalleryDetailModel alloc] initWithDic:self.article];
        
        [self.articleModelArray addObject:model];
        [model release];
        
    }
    
    return self;
}

@end
