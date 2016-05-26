//
//  LTTopicArticleModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

#import "LTArticleDetailModel.h"

@interface LTTopicArticleModel : LTBaseModel

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** article 字典 对应 ArticleDetailModel */
@property (nonatomic, retain) NSDictionary *article;

/** 存储 ArticleDetailModel 的数组 */
@property (nonatomic, retain) NSMutableArray *articleDetailModelArray;

@end
