//
//  LTTopicListModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTopicListModel.h"

@implementation LTTopicListModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.entranceModelArray = [[NSMutableArray alloc] init];
        
        self.galleryModelArray = [[NSMutableArray alloc] init];
        
        self.articleModelArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in self.entrance) {
            
            LTTopicEntranceModel *model = [[LTTopicEntranceModel alloc] initWithDic:dict];
            
            [self.entranceModelArray addObject:model];
            [model release];
            
        }
        
        for (NSDictionary *dict in self.gallery) {
            
            LTTopicGalleryModel *model = [[LTTopicGalleryModel alloc] initWithDic:dict];
            
            [self.galleryModelArray addObject:model];
            [model release];
            
        }
        
        for (NSDictionary *dict in self.article) {
            
            LTTopicArticleModel *model = [[LTTopicArticleModel alloc] initWithDic:dict];
            
            [self.articleModelArray addObject:model];
            [model release];
            
        }
        
    }
    
    return self;
}

@end
