//
//  LTTopicDailyModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

#import "LTTopicListModel.h"

@interface LTTopicDailyModel : LTBaseModel

/** 日期 */
@property (nonatomic, copy) NSString *date;

/** 话题列表 */
@property (nonatomic, retain) NSArray *topic_list;

/** 存储topicListModel的数组 */
@property (nonatomic, retain) NSMutableArray *topicListArray;

@end
