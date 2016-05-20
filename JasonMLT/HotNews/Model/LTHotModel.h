//
//  LTHotModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"
#import "LTHotStyleModel.h"
#import "LTHotLinkModel.h"

@class Link;

@interface LTHotModel : LTBaseModel


@property (nonatomic, copy) NSString *documentId;

/** 评论数 */
@property (nonatomic, copy) NSString *comments;

/** 当type = slide 时 style 中的images数组存储三张图 */
@property (nonatomic, retain) LTHotStyleModel *styleModel;

/** 存储styleModel */
@property (nonatomic, retain) NSMutableArray *styleArray;

/** 接收style字典 */
@property (nonatomic, retain) NSMutableDictionary *style;

/** 点击进入详细页的链接? */
@property (nonatomic, strong) LTHotLinkModel *link;

/** 消息来源 */
@property (nonatomic, copy) NSString *source;

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;

/** 不知道是啥玩意 */
@property (nonatomic, copy) NSString *commentsall;

/** type = doc 为单图, slide为3张图 */
@property (nonatomic, copy) NSString *type;

/** 单张图片 */
@property (nonatomic, copy) NSString *thumbnail;

/** 新闻时间 */
@property (nonatomic, copy) NSString *updateTime;



@end



