//
//  LTMainListModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/24.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTMainListModel : LTBaseModel

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 文章来源 */
@property (nonatomic, copy) NSString *auther_name;

/** 文章跳转链接 */
@property (nonatomic, copy) NSString *weburl;

/** 文章日期 */
@property (nonatomic, copy) NSString *date;

/** 图片 */
@property (nonatomic, copy) NSString *thumbnail_mpic;

/** 图片尺寸 */
@property (nonatomic, copy) NSString *thumbnail_picsize;

/** 不知道是啥属性 */
@property (nonatomic, copy) NSString *full_url;


@end
