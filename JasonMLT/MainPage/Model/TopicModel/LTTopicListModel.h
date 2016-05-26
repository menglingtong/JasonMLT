//
//  LTTopicListModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

#import "LTTopicEntranceModel.h"

#import "LTTopicGalleryModel.h"

#import "LTTopicArticleModel.h"

@interface LTTopicListModel : LTBaseModel

/** 话题入口 每个模块的最后一条 对应 LTTopicEntranceModel */
@property (nonatomic, retain) NSArray *entrance;

/** 存储 LTTopicEntranceModel 的数组 */
@property (nonatomic, retain) NSMutableArray *entranceModelArray;

/** 图片 每个模块的第一条大图 对应 LTTopicGalleryModel */
@property (nonatomic, retain) NSArray *gallery;

/** 存储 LTTopicGalleryModel 的数组 */
@property (nonatomic, retain) NSMutableArray *galleryModelArray;

/** 文章 中间两条 对应 LTTopicArticleModel */
@property (nonatomic, retain) NSArray *article;

/** 存储 LTTopicArticleModel 的数组 */
@property (nonatomic, retain) NSMutableArray *articleModelArray;

@end
