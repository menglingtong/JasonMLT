//
//  LTTopicGalleryModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/25.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTTopicGalleryModel : LTBaseModel

/** 图片高度 */
@property (nonatomic, copy) NSString *img_height;

/** 图片宽度 */
@property (nonatomic, copy) NSString *img_width;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 图片链接地址 */
@property (nonatomic, copy) NSString *promotion_img;

/** article 字典 对应 GalleryDetailModel */
@property (nonatomic, retain) NSDictionary *article;

/** 存储 GalleryDetailModel 的数组 */
@property (nonatomic, retain) NSMutableArray *articleModelArray;


@end
