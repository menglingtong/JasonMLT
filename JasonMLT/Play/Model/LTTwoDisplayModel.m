//
//  LTTwoDisplayModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTTwoDisplayModel.h"
#import "LTDisplayPicModel.h"
#import "LTDisplayWebModel.h"

@implementation LTTwoDisplayModel

- (void)dealloc
{
    [_picModelArray release];
    [_webModelArray release];
    
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.picModelArray = [[NSMutableArray alloc] init];
        self.webModelArray = [[NSMutableArray alloc] init];
        
        LTDisplayPicModel *picModel = [[LTDisplayPicModel alloc] initWithDic:self.pic];
        
        [self.picModelArray addObject:picModel];
        [picModel release];
        
        LTDisplayWebModel *webModel = [[LTDisplayWebModel alloc] initWithDic:self.block_info];
        
        [self.webModelArray addObject:webModel];
        [webModel release];
        
    }
    
    return self;
}

@end
