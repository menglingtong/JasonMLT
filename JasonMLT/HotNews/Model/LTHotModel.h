//
//  LTHotModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/19.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"
#import "LTThumbnailMediasModel.h"

@interface LTHotModel : LTBaseModel

/** 文章来源 */
@property (nonatomic, copy) NSString *auther_name;

/** 文章日期 */
@property (nonatomic, copy) NSString *date;

/** 暂时不明确用途的url */
@property (nonatomic, copy) NSString *full_url;

/** 判断是否使用上述url */
@property (nonatomic, assign) BOOL is_full;

/** model */
@property (nonatomic, retain) LTThumbnailMediasModel *LTThumbnailMediasModel;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 网络链接 */
@property (nonatomic, copy) NSString *weburl;





@end
