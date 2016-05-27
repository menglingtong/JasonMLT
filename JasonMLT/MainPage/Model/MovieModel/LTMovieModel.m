//
//  LTMovieModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTMovieModel.h"

@implementation LTMovieModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.autherModelArray = [[NSMutableArray alloc] init];
        
        self.mediaModelArray = [[NSMutableArray alloc] init];
        
        LTMovieAutherModel *autherModel = [[LTMovieAutherModel alloc] initWithDic:self.auther];
        
        [self.autherModelArray addObject:autherModel];
        [autherModel release];
        
        
        for (NSDictionary *dict in self.medias) {
            
            LTMovieMediasModel *mediaModel = [[LTMovieMediasModel alloc] initWithDic:dict];
            
            [self.mediaModelArray addObject:mediaModel];
            [mediaModel release];
            
        }
        
        
    }
    
    return self;
}

@end
