//
//  LTGalleryDetailModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTGalleryDetailModel : LTBaseModel


/** 网页链接 */
@property (nonatomic, copy) NSString *weburl;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 日期 */
@property (nonatomic, copy) NSString *date;

/** 文章来源 */
@property (nonatomic, copy) NSString *auther_name;

/** 不知道是啥链接 */
@property (nonatomic, copy) NSString *full_url;


@end
