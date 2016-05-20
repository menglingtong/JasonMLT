//
//  LTThumbnailMedias.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/20.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTThumbnailMediasModel : LTBaseModel

/** 图片高度 */
@property (nonatomic, assign) NSInteger h;

/** 图片url */
@property (nonatomic, copy) NSString *m_url;

/** 类型 */
@property (nonatomic, copy) NSString *type;

/** 图片宽 */
@property (nonatomic, assign) NSInteger *w;


@end
