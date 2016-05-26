//
//  LTTopicEntranceModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

#import "LTEntranceDetailModel.h"

@interface LTTopicEntranceModel : LTBaseModel

/** 入口标题 */
@property (nonatomic, copy) NSString *title;

/** topic 字典 对应 EntranceDetailModel */
@property (nonatomic, retain) NSDictionary *topic;

/** 存储  EntranceDetailModel 的数组 */
@property (nonatomic, retain) NSMutableArray *entranceDetailModelArray;


@end
