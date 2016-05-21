//
//  LTSectionModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTSectionModel.h"

@implementation LTSectionModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    self.playModelArray = [[NSMutableArray alloc] init];
    
    self.bannerModelArray = [[NSMutableArray alloc] init];
    
    if (self) {
        
        for (NSDictionary *dictionary in self.items) {
            
            LTPlayModel *model = [[LTPlayModel alloc] initWithDic:dictionary];
            
            [self.playModelArray addObject:model];
            [model release];
            
        }
        
        
        LTBannerModel *bannerModel = [[LTBannerModel alloc] initWithDic:self.banner];
        
        [self.bannerModelArray addObject:bannerModel];
        [bannerModel release];
        
    }
    
    return self;
}

@end



