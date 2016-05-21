//
//  LTPlayModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/21.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"
#import "LTArticleModel.h"
#import "LTPicModel.h"


@interface LTPlayModel : LTBaseModel

/** 图片上面的大字 标题 */
@property (nonatomic, copy) NSString *content;

/** 图片上的小字 标题 */
@property (nonatomic, copy) NSString *title;

/** 存储了跳转链接 */
@property (nonatomic, retain) NSDictionary *article;

/** 存储了图片链接 */
@property (nonatomic, retain) NSDictionary *pic;

/** LTArticleModel */
@property (nonatomic, retain) LTArticleModel *articleModel;

@property (nonatomic, retain) NSMutableArray *articleModelArray;

/** LTPicModel */
@property (nonatomic, retain) LTPicModel *picModel;

@property (nonatomic, retain) NSMutableArray *picModelArray;

@end





