//
//  LTSectionModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"
#import "LTPlayModel.h"
#import "LTBannerModel.h"

@interface LTSectionModel : LTBaseModel

/** section title */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, retain) NSArray *items;

@property (nonatomic, retain) NSDictionary *banner;

@property (nonatomic, retain) NSMutableArray *playModelArray;

@property (nonatomic, retain) NSMutableArray *bannerModelArray;

@end


