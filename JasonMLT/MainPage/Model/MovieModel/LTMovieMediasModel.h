//
//  LTMovieMediasModel.h
//  JasonMLT
//
//  Created by 孟令通 on 16/5/27.
//  Copyright © 2016年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTMovieMediasModel : LTBaseModel

/** 图片高 */
@property (nonatomic, copy) NSString *h;

/** 图片类型 */
@property (nonatomic, copy) NSString *type;

/** 图片宽 */
@property (nonatomic, copy) NSString *w;

/** 图片链接 */
@property (nonatomic, copy) NSString *url;


@end
