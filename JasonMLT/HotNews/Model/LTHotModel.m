//
//  LTHotModel.m
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTHotModel.h"

#import "LTNetTool.h"

@implementation LTHotModel

-(void)dealloc
{
    [_styleArray release];
    [_linkModel release];
    [super dealloc];
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    
    self = [super initWithDic:dic];
    
    if (self) {
        
        self.styleArray = [[NSMutableArray alloc] init];
        
        self.linkModelArray = [[NSMutableArray alloc] init];
        
        LTHotStyleModel *model = [[LTHotStyleModel alloc] initWithDic:self.style];
        
        [self.styleArray addObject:model];
        [model release];
        
        
        LTHotLinkModel *linkModel = [[LTHotLinkModel alloc] initWithDic:self.link];
        
        [self.linkModelArray addObject:linkModel];
        [linkModel release];
        
        [self askForUrl:linkModel.url];
        
        
    }
    
    
    return self;
}

- (void) askForUrl:(NSString *)url
{
    [LTNetTool GetNetWithUrl:url body:nil header:nil response:LTJSON success:^(id result) {
        
        self.wapurl = [[result objectForKey:@"body"] objectForKey:@"wapurl"];
        
    } failure:^(NSError *error) {
        
        
        
    }];
}

@end
