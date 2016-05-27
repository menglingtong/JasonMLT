//
//  LTMovieModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

#import "LTMovieAutherModel.h"

#import "LTMovieMediasModel.h"

@interface LTMovieModel : LTBaseModel

/** 跳转链接 */
@property (nonatomic, copy) NSString *weburl;

/** 描述文字 */
@property (nonatomic, copy) NSString *content;


@property (nonatomic, copy) NSString *content_url;

/** 日期 */
@property (nonatomic, copy) NSString *date;

/** 评论数 */
@property (nonatomic, copy) NSString *comment_count;

/** 热度 */
@property (nonatomic, copy) NSString *hot_num;

/** 点赞数 */
@property (nonatomic, copy) NSString *like_num;


@property (nonatomic, copy) NSString *list_date;

/** 作者信息 */
@property (nonatomic, retain) NSDictionary *auther;

@property (nonatomic, retain) NSMutableArray *autherModelArray;

/** 图片信息 */
@property (nonatomic, retain) NSArray *medias;

@property (nonatomic, retain) NSMutableArray *mediaModelArray;


@end
